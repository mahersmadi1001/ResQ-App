import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:projct/model/item_munu_modal.dart';

enum ReportInputStatus {
  idle,
  typingOrAttachment,
  recording,
  //  OptionSelect
}

class ReportInputState extends Equatable {
  final String text;
  final List<AssetEntity> attachments;
  final List<AttachmentItem> selectedIncidentTypes;
  final ReportInputStatus status;
  final int recordingDuration; // in seconds
  final int? recordedAudioDuration; // null means no audio
  final String? recordedAudioPath; // actual file path

  const ReportInputState({
    this.text = "",
    this.attachments = const [],
    this.selectedIncidentTypes = const [],
    this.status = ReportInputStatus.idle,
    this.recordingDuration = 0,
    this.recordedAudioDuration,
    this.recordedAudioPath,
  });

  ReportInputState copyWith({
    String? text,
    List<AssetEntity>? attachments,
    List<AttachmentItem>? selectedIncidentTypes,
    ReportInputStatus? status,
    int? recordingDuration,
    int? recordedAudioDuration,
    String? recordedAudioPath,
    bool clearAudio = false,
  }) {
    return ReportInputState(
      text: text ?? this.text,
      attachments: attachments ?? this.attachments,
      selectedIncidentTypes: selectedIncidentTypes ?? this.selectedIncidentTypes,
      status: status ?? this.status,
      recordingDuration: recordingDuration ?? this.recordingDuration,
      recordedAudioDuration: clearAudio ? null : (recordedAudioDuration ?? this.recordedAudioDuration),
      recordedAudioPath: clearAudio ? null : (recordedAudioPath ?? this.recordedAudioPath),
    );
  }

  @override
  List<Object?> get props =>
      [text, attachments, selectedIncidentTypes, status, recordingDuration, recordedAudioDuration, recordedAudioPath];
}
