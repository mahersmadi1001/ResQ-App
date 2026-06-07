import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';

import 'package:projct/viwe/login_screen.dart';

class NavigatToLogin extends StatelessWidget {
  const NavigatToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "If you have an account :",
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
          },
          child: Text(
            "Login",
            style: TextStyle(
              shadows: [Shadow(blurRadius: 10, offset: Offset(2, 4))],
              color: ColorsApp.yalwoPro,
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
