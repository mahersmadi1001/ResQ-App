import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'media_picker_event.dart';
import 'media_picker_state.dart';

class MediaPickerBloc extends Bloc<MediaPickerEvent, MediaPickerState> {
  static const int _pageSize = 80;

  MediaPickerBloc() : super(MediaPickerInitial()) {
    on<RequestMediaPermissions>(_onRequestPermissions);
    on<FetchMedia>(_onFetchMedia);
    on<ToggleMediaSelection>(_onToggleSelection);
    on<AddNewCapturedMedia>(_onAddNewCaptured);
  }

  Future<void> _onRequestPermissions(
      RequestMediaPermissions event, Emitter<MediaPickerState> emit) async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth || ps.hasAccess) {
      add(FetchMedia(page: 0));
    } else {
      emit(MediaPickerPermissionDenied());
    }
  }

  Future<void> _onFetchMedia(
      FetchMedia event, Emitter<MediaPickerState> emit) async {
    try {
      List<AssetEntity> currentMedia = [];
      List<AssetEntity> currentSelected = [];
      bool currentHasMore = true;

      if (state is MediaPickerLoaded && event.page > 0) {
        final currentState = state as MediaPickerLoaded;
        currentMedia = List.from(currentState.mediaList);
        currentSelected = List.from(currentState.selectedMedia);
      } else {
        emit(MediaPickerLoading());
      }

      final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.common,
        onlyAll: true,
      );

      if (albums.isEmpty) {
        emit(MediaPickerLoaded(
            mediaList: currentMedia,
            selectedMedia: currentSelected,
            currentPage: event.page,
            hasMore: false));
        return;
      }

      final AssetPathEntity recentAlbum = albums.first;
      final List<AssetEntity> newMedia = await recentAlbum.getAssetListPaged(
        page: event.page,
        size: _pageSize,
      );

      currentMedia.addAll(newMedia);
      currentHasMore = newMedia.length == _pageSize;

      emit(MediaPickerLoaded(
        mediaList: currentMedia,
        selectedMedia: currentSelected,
        currentPage: event.page,
        hasMore: currentHasMore,
      ));
    } catch (e) {
      emit(MediaPickerError(message: e.toString()));
    }
  }

  void _onToggleSelection(
      ToggleMediaSelection event, Emitter<MediaPickerState> emit) {
    if (state is MediaPickerLoaded) {
      final currentState = state as MediaPickerLoaded;
      final List<AssetEntity> selected = List.from(currentState.selectedMedia);

      if (selected.contains(event.asset)) {
        selected.remove(event.asset);
      } else {
        selected.add(event.asset);
      }

      emit(currentState.copyWith(selectedMedia: selected));
    }
  }

  void _onAddNewCaptured(
      AddNewCapturedMedia event, Emitter<MediaPickerState> emit) {
    if (state is MediaPickerLoaded) {
      final currentState = state as MediaPickerLoaded;
      final List<AssetEntity> currentMedia =
          List.from(currentState.mediaList);
      final List<AssetEntity> selected = List.from(currentState.selectedMedia);

      // Add to beginning of the list
      currentMedia.insert(0, event.asset);
      selected.add(event.asset);

      emit(currentState.copyWith(
        mediaList: currentMedia,
        selectedMedia: selected,
      ));
    }
  }
}
