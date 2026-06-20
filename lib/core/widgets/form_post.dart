// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/model/post_model%20.dart';

class FormPost extends StatelessWidget {
  final String descration;
  final Address address;
  final String date;
  final String time;
  final String? imagePath;
  final VoidCallback? ontap;

  const FormPost({
    Key? key,
    required this.address,
    required this.descration,
    required this.date,
    required this.time,
    required this.imagePath,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      elevation: 7,
      shadowColor: Colors.black.withAlpha(200),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      color: ColorsApp.yalwoPro,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: ontap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImage(),

            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          descration.replaceAll('[', '').replaceAll(']', ''),
                          style: TextStyle(
                            color: ColorsApp.greenPro,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.bookmark_border_rounded,
                        color: ColorsApp.withePro,
                        size: 28.sp,
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 20.sp,
                        color: ColorsApp.greenPro,
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          '${address.governorate}, ${address.city}, ${address.street}',
                          style: TextStyle(
                            color: ColorsApp.withePro,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        size: 18.sp,
                        color: ColorsApp.greenPro,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        date,
                        style: TextStyle(
                          color: ColorsApp.withePro,
                          fontSize: 16.sp,
                        ),
                      ),

                      SizedBox(width: 20.w),

                      Icon(
                        Icons.access_time_rounded,
                        size: 18.sp,
                        color: ColorsApp.greenPro,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        time,
                        style: TextStyle(
                          color: ColorsApp.withePro,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imagePath != null && imagePath!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imagePath!,
        width: double.infinity,
        height: 180.h,
        fit: BoxFit.cover,
        placeholder: (context, url) => SizedBox(
          height: 180.h,
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => _buildErrorImage(),
      );
    } else {
      return _buildErrorImage();
    }
  }

  Widget _buildErrorImage() {
    return Container(
      width: double.infinity,
      height: 180.h,
      color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_rounded,
            size: 45.sp,
            color: ColorsApp.greenPro,
          ),
          SizedBox(height: 8.h),
          Text(
            "الصورة غير متوفرة",
            style: TextStyle(color: ColorsApp.withePro, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
