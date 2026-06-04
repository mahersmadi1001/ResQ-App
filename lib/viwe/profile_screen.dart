
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/constens/constens.dart';
import 'package:projct/core/widgets/logout_dialog.dart';

import 'package:projct/core/widgets/setting_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: 436.w,
            height: 200.h,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 130.h,
                    width: 436.w,
                    color: ColorsApp.greenPro,
                  ),
                ),
                Positioned(
                  bottom: 0.h,
                  right: 129.w,
                  child: CircleAvatar(
                    maxRadius: 80,
                    backgroundColor: ColorsApp.greenPro,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0.r),
                      child: Image.asset(
                        ConstensApp.logo,
                        fit: BoxFit.fill,
                        width: 140.w,
                        height: 140.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Maher Smadi",
            style: TextStyle(
              color: ColorsApp.yalwoPro,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30.h),
          Expanded(
            child: ListView(
              children: [
                SettingItem(
                  icon: Icons.person_outline_outlined,
                  text: "Profile Ditals",
                ),

                SettingItem(
                  icon: Icons.notifications_none_outlined,
                  text: "Notifications",
                ),
                SettingItem(icon: Icons.language_sharp, text: "Language"),
                SettingItem(icon: Icons.history_sharp, text: "History"),
                SettingItem(
                  icon: Icons.dark_mode_outlined,
                  text: "Dark Mode",
                  switchMode: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeThumbColor: ColorsApp.blackPro,
                    activeTrackColor: ColorsApp.yalwoPro,
                  ),
                ),
                SettingItem(
                  ontap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return LogoutDialog();
                      },
                    );
                  },
                  icon: Icons.logout,
                  text: "LogOut",
                  colorTextAndIcon: Colors.red.shade400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
