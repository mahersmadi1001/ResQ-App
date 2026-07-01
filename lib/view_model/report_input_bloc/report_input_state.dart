import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

enum ReportInputStatus {
  idle,
  typingOrAttachment,
  recording,
  //  OptionSelect
}

class ReportInputState extends Equatable {
  final String text;
  final List<AssetEntity> attachments;
  final ReportInputStatus status;
  final int recordingDuration;

  const ReportInputState({
    this.text = "",
    this.attachments = const [],
    this.status = ReportInputStatus.idle,
    this.recordingDuration = 0,
  });

  ReportInputState copyWith({
    String? text,
    List<AssetEntity>? attachments,
    ReportInputStatus? status,
    int? recordingDuration,
  }) {
    return ReportInputState(
      text: text ?? this.text,
      attachments: attachments ?? this.attachments,
      status: status ?? this.status,
      recordingDuration: recordingDuration ?? this.recordingDuration,
    );
  }

  @override
  List<Object?> get props => [text, attachments, status, recordingDuration];
}
