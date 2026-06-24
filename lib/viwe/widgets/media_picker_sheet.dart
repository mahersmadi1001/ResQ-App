import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/view_model/media_picker_bloc/media_picker_bloc.dart';
import 'package:projct/view_model/media_picker_bloc/media_picker_event.dart';
import 'package:projct/view_model/media_picker_bloc/media_picker_state.dart';
import 'package:projct/viwe/widgets/live_camera_tile.dart';
import 'package:projct/viwe/widgets/media_tile.dart';
import 'package:projct/viwe/widgets/camera_screen.dart';

class MediaPickerSheet extends StatefulWidget {
  @override
  _MediaPickerSheetState createState() => _MediaPickerSheetState();
}

class _MediaPickerSheetState extends State<MediaPickerSheet> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MediaPickerBloc>().add(RequestMediaPermissions());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final state = context.read<MediaPickerBloc>().state;
    if (state is MediaPickerLoaded && state.hasMore) {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<MediaPickerBloc>().add(FetchMedia(page: state.currentPage + 1));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          Container(
            height: 5.h,
            width: 40.w,
            margin: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          BlocBuilder<MediaPickerBloc, MediaPickerState>(
            builder: (context, state) {
              if (state is MediaPickerLoaded) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tap to select (${state.selectedMedia.length})",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      if (state.selectedMedia.isNotEmpty)
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, state.selectedMedia);
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(
                              color: ColorsApp.greenPro,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                    ],
                  ),
                );
              }
              return SizedBox(height: 30.h);
            },
          ),
          Expanded(
            child: BlocBuilder<MediaPickerBloc, MediaPickerState>(
              builder: (context, state) {
                if (state is MediaPickerPermissionDenied) {
                  return const Center(child: Text("Permission Denied"));
                }
                if (state is MediaPickerLoaded) {
                  return GridView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(2.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 2.w,
                      crossAxisSpacing: 2.w,
                    ),
                    itemCount: state.mediaList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return LiveCameraTile(
                          onTap: () async {
                            final AssetEntity? newAsset = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CameraScreen(),
                              ),
                            );
                            if (newAsset != null) {
                              context
                                  .read<MediaPickerBloc>()
                                  .add(AddNewCapturedMedia(asset: newAsset));
                            }
                          },
                        );
                      }
                      final asset = state.mediaList[index - 1];
                      final isSelected = state.selectedMedia.contains(asset);

                      return MediaTile(
                        asset: asset,
                        isSelected: isSelected,
                        onTap: () {
                          context
                              .read<MediaPickerBloc>()
                              .add(ToggleMediaSelection(asset: asset));
                        },
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
