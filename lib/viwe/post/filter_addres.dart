import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/localization/app_localizations.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/chips_address.dart';
import 'package:projct/view_model/post_bloc/post_bloc.dart';

Future<dynamic> filterAddres(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(height: 16.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey.shade600,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey.shade200),
            SizedBox(height: 12.h),

            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 350.h),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: const FilterAddressPost(),
              ),
            ),

            SizedBox(height: 20.h),

            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  context.read<PostBloc>().add(
                    GetAllPost(filterParamtr: FilterAddressPost.optiosSelected),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellowPro,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  context.tr("general.confirm_selection"),
                  style: TextStyle(
                    color: AppColors.greenPro,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      );
    },
  );
}
