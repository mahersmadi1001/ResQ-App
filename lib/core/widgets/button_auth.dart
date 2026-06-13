// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';

class ButtonAuth extends StatelessWidget {
  VoidCallback? onPressed;
  double minWidth = 250.w;
  String textButton;
  ButtonAuth({
    Key? key,
    required this.onPressed,
    this.minWidth = 250,
    this.textButton = "Send",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: ColorsApp.yalwoPro,
      onPressed: onPressed,
      minWidth: minWidth,
      height: 45.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14.r)),
      ),
      elevation: 10,
      child: Text(
        textButton,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
