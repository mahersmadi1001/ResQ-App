import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/viwe/login_screen.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.cancel, color: Colors.red.shade200, size: 50.sp),
      scrollable: true,
      backgroundColor: Colors.white,
      content: Text(
        " you wante is Logout ?",
        style: TextStyle(color: ColorsApp.yalwoPro, fontSize: 20.sp),
      ),
      title: Text("LogOut", style: TextStyle(color: Colors.red)),
      actions: [
        Row(
          spacing: 20.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withAlpha(200),
              ),
              onPressed: () {},
              child: Text(
                "cancel",
                style: TextStyle(color: ColorsApp.yalwoPro),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp.greenPro,
              ),
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
              child: Text("yes", style: TextStyle(color: ColorsApp.yalwoPro)),
            ),
          ],
        ),
      ],
    );
  }
}
