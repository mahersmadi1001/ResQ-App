import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/button_auth.dart';
import 'package:projct/viwe/bottom_nav_bar.dart';
import 'package:projct/viwe/login_screen.dart';
import 'package:projct/viwe/sign_up/signup_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 22.sp,
        color: ColorsApp.greenPro,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorsApp.yalwoPro, width: 2),
      ),
    );

    final focusedPinTheme = PinTheme(
      textStyle: TextStyle(color: ColorsApp.greenPro, fontSize: 25.sp),
      width: 56.w,
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: ColorsApp.yalwoPro, width: 3),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: Colors.redAccent),
      ),
    );

    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.key, size: 50.sp, color: ColorsApp.greenPro),
              Text(
                "تحقق من الرمز",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.greenPro,
                ),
              ),

              SizedBox(height: 30.h),

              Pinput(
                controller: pinController,
                focusNode: focusNode,
                length: 6,
                separatorBuilder: (index) => SizedBox(width: 14.w),

                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                errorPinTheme: errorPinTheme,

                validator: (value) {
                  return value == '222222' ? null : 'الرمز غير صحيح';
                },

                hapticFeedbackType: HapticFeedbackType.lightImpact,
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 2.h,
                      width: 20.w,
                      color: ColorsApp.greenPro,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),
              ButtonAuth(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ButtonNavBar();
                        },
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    child: Text(
                      "إعادة إرسال الرمز",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: ColorsApp.greenPro,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Divider(endIndent: 100.w, indent: 100.w),
              SizedBox(height: 40.h),
              Text("OR"),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                        color: ColorsApp.yalwoPro,
                        fontSize: 22.sp,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignupScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "SginUp",
                      style: TextStyle(
                        color: ColorsApp.yalwoPro,
                        fontSize: 22.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
