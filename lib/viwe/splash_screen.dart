import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/constens/constens.dart';

import 'package:projct/viwe/onbording_pages/pagesview.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2, milliseconds: 300), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return OnBordingPageView();
          },
        ),
      );
    });
  }

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
          SizedBox(height: 150.h), 
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
