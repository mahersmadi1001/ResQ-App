import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'report_input_event.dart';
import 'report_input_state.dart';
import 'package:projct/model/item_munu_modal.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

class ReportInputBloc extends Bloc<ReportInputEvent, ReportInputState> {
  Timer? _recordingTimer;
  final _audioRecorder = AudioRecorder();

  ReportInputBloc() : super(const ReportInputState()) {
    on<TextChanged>(_onTextChanged);
    on<AttachmentsAdded>(_onAttachmentsAdded);
    on<AttachmentRemoved>(_onAttachmentRemoved);
    on<StartRecording>(_onStartRecording);
    on<CancelRecording>(_onCancelRecording);
    on<StopRecording>(_onStopRecording);
    on<RecordingDurationUpdated>(_onRecordingDurationUpdated);
    on<IncidentTypesChanged>(_onIncidentTypesChanged);
    on<RemoveAudio>(_onRemoveAudio);
    on<ClearInput>(_onClearInput);
  }

  void _onTextChanged(TextChanged event, Emitter<ReportInputState> emit) {
    final newStatus = _determineStatus(
        event.text, state.attachments, state.selectedIncidentTypes, state.recordedAudioDuration);
    emit(state.copyWith(text: event.text, status: newStatus));
  }

  void _onAttachmentsAdded(
    AttachmentsAdded event,
    Emitter<ReportInputState> emit,
  ) {
    final updatedAttachments = List<AssetEntity>.from(state.attachments)
      ..addAll(event.newAttachments);
    final newStatus = _determineStatus(
        state.text, updatedAttachments, state.selectedIncidentTypes, state.recordedAudioDuration);
    emit(state.copyWith(attachments: updatedAttachments, status: newStatus));
  }

  void _onAttachmentRemoved(
    AttachmentRemoved event,
    Emitter<ReportInputState> emit,
  ) {
    final updatedAttachments = List<AssetEntity>.from(state.attachments)
      ..remove(event.attachment);
    final newStatus = _determineStatus(
        state.text, updatedAttachments, state.selectedIncidentTypes, state.recordedAudioDuration);
    emit(state.copyWith(attachments: updatedAttachments, status: newStatus));
  }

  void _onIncidentTypesChanged(
    IncidentTypesChanged event,
    Emitter<ReportInputState> emit,
  ) {
    final newStatus = _determineStatus(
        state.text, state.attachments, event.selectedTypes, state.recordedAudioDuration);
    emit(state.copyWith(selectedIncidentTypes: event.selectedTypes, status: newStatus));
  }

  Future<void> _onStartRecording(StartRecording event, Emitter<ReportInputState> emit) async {
    if (await _audioRecorder.hasPermission()) {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/report_audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _audioRecorder.start(const RecordConfig(), path: path);
      
      _recordingTimer?.cancel();
      emit(
        state.copyWith(status: ReportInputStatus.recording, recordingDuration: 0),
      );
      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        add(RecordingDurationUpdated(timer.tick));
      });
    }
  }

  Future<void> _onCancelRecording(
    CancelRecording event,
    Emitter<ReportInputState> emit,
  ) async {
    _recordingTimer?.cancel();
    await _audioRecorder.stop();
    emit(
      state.copyWith(
        status: _determineStatus(
          state.text,
          state.attachments,
          state.selectedIncidentTypes,
          null,
        ),
        recordingDuration: 0,
        clearAudio: true, 
      ),
    );
  }

  Future<void> _onStopRecording(StopRecording event, Emitter<ReportInputState> emit) async {
    _recordingTimer?.cancel();
    final path = await _audioRecorder.stop();
    emit(
      state.copyWith(
        status: _determineStatus(
          state.text,
          state.attachments,
          state.selectedIncidentTypes,
          state.recordingDuration, 
        ),
        recordedAudioDuration: state.recordingDuration,
        recordingDuration: 0,
        recordedAudioPath: path,
      ),
    );
  }

  void _onRemoveAudio(RemoveAudio event, Emitter<ReportInputState> emit) {
    emit(
      state.copyWith(
        status: _determineStatus(
          state.text,
          state.attachments,
          state.selectedIncidentTypes,
          null,
        ),
        clearAudio: true,
      ),
    );
  }

  void _onRecordingDurationUpdated(
    RecordingDurationUpdated event,
    Emitter<ReportInputState> emit,
  ) {
    if (state.status == ReportInputStatus.recording) {
      emit(state.copyWith(recordingDuration: event.duration));
    }
  }

  void _onClearInput(ClearInput event, Emitter<ReportInputState> emit) {
    emit(const ReportInputState());
  }

  ReportInputStatus _determineStatus(
    String text,
    List<dynamic> attachments,
    List<dynamic> incidentTypes,
    int? audioDuration,
  ) {
    if (text.isNotEmpty || attachments.isNotEmpty || audioDuration != null) {
      return ReportInputStatus.typingOrAttachment;
    }
    return ReportInputStatus.idle;
  }

  @override
  Future<void> close() {
    _recordingTimer?.cancel();
    _audioRecorder.dispose();
    return super.close();
  }
}
