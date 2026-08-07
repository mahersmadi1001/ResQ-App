import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/localization/app_localizations.dart';
import 'package:projct/core/theme/colors_app.dart';

class BoxTextRepot extends StatelessWidget {
  const BoxTextRepot({super.key, required this.statment});

  final String statment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: AppColors.yellowPro.withOpacity(0.15),
          border: Border(
            left: BorderSide(color: AppColors.yellowPro, width: 4.w),
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.greenPro,
                  size: 22.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  context.tr("report_screen.how_to_send_report"),
                  style: TextStyle(
                    color: AppColors.greenPro,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              "${AppLocalizations.trNoContext("report_screen.statement1")}\n"
              "${AppLocalizations.trNoContext("report_screen.statement2")}\n"
              "${AppLocalizations.trNoContext("report_screen.statement3")}",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
