import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

abstract class MediaPickerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestMediaPermissions extends MediaPickerEvent {}

class FetchMedia extends MediaPickerEvent {
  final int page;
  FetchMedia({this.page = 0});
  @override
  List<Object?> get props => [page];
}

class ToggleMediaSelection extends MediaPickerEvent {
  final AssetEntity asset;
  ToggleMediaSelection({required this.asset});
  @override
  List<Object?> get props => [asset];
}

class AddNewCapturedMedia extends MediaPickerEvent {
  final AssetEntity asset;
  AddNewCapturedMedia({required this.asset});
  @override
  List<Object?> get props => [asset];
}
