import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/viwe/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsApp.withePro,
      width: 200.w,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 20.w,
          children: [
            const SizedBox(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfileScreen();
                    },
                  ),
                );
              },
              child: Row(
                spacing: 30.w,
                children: [
                  const Icon(Icons.settings, color: ColorsApp.yalwoPro),
                  Text(
                    "Settings",
                    style: TextStyle(
                      color: ColorsApp.yalwoPro,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
