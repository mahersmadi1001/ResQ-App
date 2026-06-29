import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:projct/view_model/report_input_bloc/report_input_bloc.dart';
import 'package:projct/view_model/report_input_bloc/report_input_event.dart';

class SelectedAttachmentsList extends StatelessWidget {
  final List<AssetEntity> attachments;

  const SelectedAttachmentsList({Key? key, required this.attachments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) return const SizedBox.shrink();
    return Container(
      height: 80.h,
      margin: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: attachments.length,
        itemBuilder: (context, index) {
          final asset = attachments[index];
          return Stack(
            children: [
              Container(
                width: 70.w,
                height: 70.h,
                margin: EdgeInsets.only(right: 10.w, top: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: FutureBuilder<Uint8List?>(
                    future: asset.thumbnailDataWithSize(const ThumbnailSize(120, 120)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(color: Colors.grey[200]);
                      }
                      if (snapshot.hasData && snapshot.data != null) {
                        return Image.memory(snapshot.data!, fit: BoxFit.cover);
                      }
                      return Container(color: Colors.grey[300]);
                    },
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 5.w,
                child: GestureDetector(
                  onTap: () {
                    context.read<ReportInputBloc>().add(AttachmentRemoved(asset));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(2.sp),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
