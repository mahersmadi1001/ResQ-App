import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:projct/model/item_munu_modal.dart';

abstract class ReportInputEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TextChanged extends ReportInputEvent {
  final String text;
  TextChanged(this.text);
  @override
  List<Object?> get props => [text];
}

class AttachmentsAdded extends ReportInputEvent {
  final List<AssetEntity> newAttachments;
  AttachmentsAdded(this.newAttachments);
  @override
  List<Object?> get props => [newAttachments];
}

class AttachmentRemoved extends ReportInputEvent {
  final AssetEntity attachment;
  AttachmentRemoved(this.attachment);
  @override
  List<Object?> get props => [attachment];
}

class StartRecording extends ReportInputEvent {}

class CancelRecording extends ReportInputEvent {}

class StopRecording extends ReportInputEvent {}

class RecordingDurationUpdated extends ReportInputEvent {
  final int duration;
  RecordingDurationUpdated(this.duration);
  @override
  List<Object?> get props => [duration];
}

class ClearInput extends ReportInputEvent {}

// class SelecteOption extends ReportInputEvent {
//   List<AttachmentItem> Options = [];
//   @override
//   List<Object?> get props => [Options];
//   SelecteOption({required this.Options});
// }
