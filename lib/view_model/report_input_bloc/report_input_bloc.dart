import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'report_input_event.dart';
import 'report_input_state.dart';

class ReportInputBloc extends Bloc<ReportInputEvent, ReportInputState> {
  Timer? _recordingTimer;

  ReportInputBloc() : super(const ReportInputState()) {
    on<TextChanged>(_onTextChanged);
    on<AttachmentsAdded>(_onAttachmentsAdded);
    on<AttachmentRemoved>(_onAttachmentRemoved);
    on<StartRecording>(_onStartRecording);
    on<CancelRecording>(_onCancelRecording);
    on<StopRecording>(_onStopRecording);
    on<RecordingDurationUpdated>(_onRecordingDurationUpdated);
    on<ClearInput>(_onClearInput);
  }

  void _onTextChanged(TextChanged event, Emitter<ReportInputState> emit) {
    final newStatus = _determineStatus(event.text, state.attachments);
    emit(state.copyWith(text: event.text, status: newStatus));
  }

  void _onAttachmentsAdded(
    AttachmentsAdded event,
    Emitter<ReportInputState> emit,
  ) {
    final updatedAttachments = List<AssetEntity>.from(state.attachments)
      ..addAll(event.newAttachments);
    final newStatus = _determineStatus(state.text, updatedAttachments);
    emit(state.copyWith(attachments: updatedAttachments, status: newStatus));
  }

  void _onAttachmentRemoved(
    AttachmentRemoved event,
    Emitter<ReportInputState> emit,
  ) {
    final updatedAttachments = List<AssetEntity>.from(state.attachments)
      ..remove(event.attachment);
    final newStatus = _determineStatus(state.text, updatedAttachments);
    emit(state.copyWith(attachments: updatedAttachments, status: newStatus));
  }

  void _onStartRecording(StartRecording event, Emitter<ReportInputState> emit) {
    _recordingTimer?.cancel();
    emit(
      state.copyWith(status: ReportInputStatus.recording, recordingDuration: 0),
    );
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(RecordingDurationUpdated(timer.tick));
    });
  }

  void _onCancelRecording(
    CancelRecording event,
    Emitter<ReportInputState> emit,
  ) {
    _recordingTimer?.cancel();
    emit(
      state.copyWith(
        status: _determineStatus(state.text, state.attachments),
        recordingDuration: 0,
      ),
    );
  }

  void _onStopRecording(StopRecording event, Emitter<ReportInputState> emit) {
    _recordingTimer?.cancel();
    emit(
      state.copyWith(
        status: _determineStatus(state.text, state.attachments),
        recordingDuration: 0,
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

  ReportInputStatus _determineStatus(String text, List<dynamic> attachments) {
    if (text.isNotEmpty || attachments.isNotEmpty) {
      return ReportInputStatus.typingOrAttachment;
    }
    return ReportInputStatus.idle;
  }

  @override
  Future<void> close() {
    _recordingTimer?.cancel();
    return super.close();
  }
}
