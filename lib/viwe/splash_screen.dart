import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/constens/constens.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.greenPro,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              ConstensApp.logo,
              fit: BoxFit.fill,
              width: 200.w,
              height: 200.h,
            ),
          ),
          SizedBox(height: 30.h),
          Text(
            "ResQ",
            style: TextStyle(
              color: ColorsApp.yalwoPro,
              fontSize: 35.sp,
              fontWeight: FontWeight.bold,
              shadows: [
                const Shadow(
                  color: Colors.black,
                  blurRadius: 5,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
          SizedBox(height: 90.h),
          SizedBox(
            width: 275.w,
            child: LinearProgressIndicator(
              minHeight: 6,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              backgroundColor: ColorsApp.yalwoPro,
              color: ColorsApp.withePro,
            ),
          ),
        ],
      ),
    );
  }
}
