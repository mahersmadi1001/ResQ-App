import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';

class SettingItem extends StatelessWidget {
  IconData icon;
  GestureTapCallback? ontap;
  String text;
  Widget? switchMode;
  Color? colorTextAndIcon;
  SettingItem({
    Key? key,
    required this.icon,
    required this.text,
    this.switchMode,
    this.ontap,
    this.colorTextAndIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.sp),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Icon(
                    icon,
                    size: 34.sp,
                    color: colorTextAndIcon ?? AppColors.yellowPro,
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: colorTextAndIcon ?? AppColors.yellowPro,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 120.w),
                switchMode ?? const SizedBox(),
              ],
            ),
          ),
        ),
   
      ],
    );
  }
}
