import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:projct/model/item_munu_modal.dart';

abstract class SendReportEvent extends Equatable {
  const SendReportEvent();

  @override
  List<Object?> get props => [];
}

class SubmitReportEvent extends SendReportEvent {
  final String text;
  final List<AttachmentItem> incidentTypes;
  final List<AssetEntity> attachments;
  final String? recordedAudioPath;

  const SubmitReportEvent({
    required this.text,
    required this.incidentTypes,
    required this.attachments,
    this.recordedAudioPath,
  });

  @override
  List<Object?> get props => [text, incidentTypes, attachments, recordedAudioPath];
}
