// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:projct/core/theme/colors_app.dart';

class FormPost extends StatelessWidget {
  String descration;
  String address;
  String date;
  String time;
  String imagePath;
  FormPost({
    Key? key,
    required this.address,
    required this.descration,
    required this.date,
    required this.time,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.h),
      margin: EdgeInsets.all(10.sp),
      height: 260.h,
      width: 400.w,
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            blurRadius: 8,
            offset: Offset(2, 2),
            blurStyle: BlurStyle.normal,
          ),
        ],

        color: ColorsApp.yalwoPro,
        borderRadius: BorderRadius.all(Radius.circular(25.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                  width: 415.w,
                  height: 160.h,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  address,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // SizedBox(width: 100.w),
                Row(
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      date,
                      style: TextStyle(
                        color: ColorsApp.withePro,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      time,
                      style: TextStyle(
                        color: ColorsApp.withePro,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.only(left: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      descration,
                      style: TextStyle(
                        color: ColorsApp.withePro,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Icon(
                        Icons.turned_in_not,
                        color: ColorsApp.withePro,
                        shadows: [
                          const Shadow(
                            color: Colors.black,
                            blurRadius: 5,
                            offset: Offset(2, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
