import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';

class SendAndMideaButton extends StatelessWidget {
  GestureTapCallback? ontap;
  IconData icon;
  SendAndMideaButton({super.key, required this.ontap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 60.h,
        width: 60.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(130),
              blurRadius: 12,
              offset: Offset(3, 3),
            ),
            BoxShadow(
              color: Colors.white.withAlpha(120),
              blurRadius: 8,
              offset: Offset(-3, -3),
            ),
          ],
          border: Border.all(color: ColorsApp.yalwoPro, width: 3),
          color: ColorsApp.greenPro,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: ColorsApp.yalwoPro, size: 25.sp),
      ),
    );
  }
}
