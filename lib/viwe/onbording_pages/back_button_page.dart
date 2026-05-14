import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';

class BackButtonPage extends StatelessWidget {
  BackButtonPage({super.key, required this.ontapBack});
  GestureTapCallback? ontapBack;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontapBack,
      child: Container(
        width: 55.w,
        height: 55.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorsApp.greenPro,

          border: Border.all(width: 3, color: ColorsApp.yalwoPro),
        ),
        child: Icon(Icons.arrow_back, color: ColorsApp.yalwoPro),
      ),
    );
  }
}
