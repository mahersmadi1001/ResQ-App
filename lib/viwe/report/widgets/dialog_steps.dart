import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/localization/app_localizations.dart';
import 'package:projct/core/theme/colors_app.dart';

void showSuccessDialog(BuildContext context, Map<String, dynamic> data) {
  final advice = data['advice'];
  final address = data['address'];

  final title = advice?['title'] ?? context.tr("general.sent_successfully");
  final steps = advice?['steps'] as List<dynamic>? ?? [];
  final street = address?['street'] ?? '';
  final city = address?['city'] ?? '';
  final governorate = address?['governorate'] ?? '';
  final addressText = [
    street,
    city,
    governorate,
  ].where((s) => s.isNotEmpty).join('، ');

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ColorsApp.greenPro, ColorsApp.greenPro.withOpacity(0.85)],
          ),
          boxShadow: [
            BoxShadow(
              color: ColorsApp.greenPro.withOpacity(0.5),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 24.h),
              decoration: BoxDecoration(
                color: ColorsApp.yalwoPro.withOpacity(0.15),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(14.r),
                    decoration: BoxDecoration(
                      color: ColorsApp.yalwoPro,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: ColorsApp.yalwoPro.withOpacity(0.4),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: ColorsApp.greenPro,
                      size: 36.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (addressText.isNotEmpty) ...[
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: ColorsApp.yalwoPro,
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          addressText,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            if (steps.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr("report_screen.safety_instructions"),
                      style: TextStyle(
                        color: ColorsApp.yalwoPro,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ...steps.asMap().entries.map((entry) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 22.w,
                              height: 22.w,
                              decoration: BoxDecoration(
                                color: ColorsApp.yalwoPro,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${entry.key + 1}',
                                  style: TextStyle(
                                    color: ColorsApp.greenPro,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                entry.value.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

            Padding(
              padding: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsApp.yalwoPro,
                    foregroundColor: ColorsApp.greenPro,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    context.tr("general.ok"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
