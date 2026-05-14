// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/viwe/onbording_pages/back_button_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnbordingPage extends StatelessWidget {
  bool isFoundSkipe;
  bool isFoundBack;
  PageController controller;
  String imagePath;
  String discrabtion;
  String textButton;
  VoidCallback? ontap;
  VoidCallback? ontapBack;
  OnbordingPage({
    Key? key,
    this.ontapBack,
    required this.isFoundBack,
    required this.controller,
    required this.isFoundSkipe,
    required this.imagePath,
    required this.discrabtion,
    required this.textButton,
    this.ontap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.withePro,
      body: Column(
        children: [
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 100.w,
                child: isFoundSkipe
                    ? TextButton(
                        onPressed: () {
                          controller.animateToPage(
                            2,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.linear,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          spacing: 3.w,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Skipe",
                              style: TextStyle(
                                color: ColorsApp.greenPro,
                                fontSize: 14.sp,
                              ),
                            ),
                            Icon(
                              size: 18.sp,
                              Icons.arrow_forward_sharp,
                              color: ColorsApp.greenPro,
                            ),
                          ],
                        ),
                      )
                    : null,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(25.r)),
              child: Image.asset(imagePath, fit: BoxFit.fill),
            ),
            height: 300.h,
            width: 400.w,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 8)],
              borderRadius: BorderRadius.all(Radius.circular(29.r)),
              border: Border.all(color: ColorsApp.yalwoPro, width: 4),
            ),
          ),
          SizedBox(height: 40.h),
          Container(
            padding: EdgeInsets.all(10.sp),
            alignment: Alignment.center,
            height: 120.h,
            width: 400.w,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  offset: Offset(2, 2),
                  spreadRadius: 0.1,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(25.r)),
              gradient: LinearGradient(
                begin: AlignmentGeometry.centerStart,
                end: AlignmentGeometry.centerEnd,
                colors: [
                  Color.fromARGB(255, 255, 243, 221),
                  ColorsApp.yalwoPro,
                ],
              ),
            ),
            child: Text(
              style: TextStyle(
                color: ColorsApp.greenPro,
                fontWeight: FontWeight.w600,
              ),
              discrabtion,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 40.h),
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: CustomizableEffect(
                activeDotDecoration: DotDecoration(
                  width: 32.w,
                  height: 12.h,
                  color: ColorsApp.yalwoPro,
                  rotationAngle: 180,
                  verticalOffset: -10,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                dotDecoration: DotDecoration(
                  width: 24.w,
                  height: 12.h,
                  color: ColorsApp.greenPro,

                  borderRadius: BorderRadius.circular(16.r),
                  verticalOffset: 0,
                ),
                spacing: 6.0.sp,
              ),
            ),
          ),

          Row(
            spacing: 15.w,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isFoundBack ? BackButtonPage(ontapBack: ontapBack) : SizedBox(),
              MaterialButton(
                child: Text(
                  textButton,
                  style: TextStyle(color: ColorsApp.yalwoPro, fontSize: 18.sp),
                ),
                onPressed: ontap,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: ColorsApp.yalwoPro, width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(25.r)),
                ),
                height: 50.h,
                color: ColorsApp.greenPro,
                minWidth: 300.w,
                elevation: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
