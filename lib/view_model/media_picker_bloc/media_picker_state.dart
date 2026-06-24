import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

abstract class MediaPickerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MediaPickerInitial extends MediaPickerState {}

class MediaPickerLoading extends MediaPickerState {}

class MediaPickerLoaded extends MediaPickerState {
  final List<AssetEntity> mediaList;
  final List<AssetEntity> selectedMedia;
  final int currentPage;
  final bool hasMore;

  MediaPickerLoaded({
    required this.mediaList,
    required this.selectedMedia,
    required this.currentPage,
    required this.hasMore,
  });

  MediaPickerLoaded copyWith({
    List<AssetEntity>? mediaList,
    List<AssetEntity>? selectedMedia,
    int? currentPage,
    bool? hasMore,
  }) {
    return MediaPickerLoaded(
      mediaList: mediaList ?? this.mediaList,
      selectedMedia: selectedMedia ?? this.selectedMedia,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [mediaList, selectedMedia, currentPage, hasMore];
}

class MediaPickerPermissionDenied extends MediaPickerState {}

class MediaPickerError extends MediaPickerState {
  final String message;
  MediaPickerError({required this.message});
  @override
  List<Object?> get props => [message];
}
