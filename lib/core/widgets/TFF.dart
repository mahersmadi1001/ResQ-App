import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';

class Tff extends StatelessWidget {
  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  FormFieldValidator<String>? validator;
  TextInputAction? textInputAction;
  String? label;
  bool obscureText;
  Widget? suffixIcon;

  Widget? prefixIcon;
  Tff({
    required this.controller,
    required this.validator,
    super.key,
    required this.label,
    this.suffixIcon,
    this.obscureText = false,
    this.prefixIcon,
    this.textInputAction,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 345.w,
      // height: 45.h,
      child: TextFormField(
        cursorErrorColor: AppColors.yellowPro,
        controller: controller,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteractionIfError,
        textInputAction: textInputAction,

        obscureText: obscureText,
        style: TextStyle(color: Colors.white),
        cursorColor: AppColors.yellowPro,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.yellowPro, fontSize: 16.sp),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.yellowPro, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(17.r)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.yellowPro, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(17.r)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(17.r)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(17.r)),
          ),
        ),
      ),
    );
  }
}
