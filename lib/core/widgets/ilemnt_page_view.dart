import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IlemntPageView extends StatelessWidget {
  IlemntPageView({
    super.key,
    required this.componant,
    required this.hight_contaner,
  });
  Widget componant;
  double hight_contaner;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Container(
            width: 370.w,
            height: hight_contaner,
            color: Colors.black.withOpacity(0.2),
            child: componant,
          ),
        ),
      ),
    );
  }
}
