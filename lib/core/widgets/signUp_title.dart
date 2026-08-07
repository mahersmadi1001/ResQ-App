import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';

class SignUpTitle extends StatelessWidget {
  const SignUpTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Sign UP",
      style: TextStyle(
        shadows: [Shadow(blurRadius: 13, offset: Offset(2, 4))],
        color: AppColors.yellowPro,
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
