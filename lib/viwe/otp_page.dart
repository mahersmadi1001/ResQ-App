import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:projct/core/config/di.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/button_auth.dart';
import 'package:projct/view_model/user_session_bloc/user_session_bloc.dart';
import 'package:projct/viwe/bottom_nav_bar.dart';
import 'package:projct/viwe/login_screen.dart';
import 'package:projct/viwe/sign_up/signup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projct/service/auth_service.dart';
import 'package:projct/view_model/otp_bloc/otp_bloc.dart';
import 'package:projct/view_model/otp_bloc/otp_event.dart';
import 'package:projct/view_model/otp_bloc/otp_state.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({super.key, required this.email});
  String email;
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

    return BlocProvider(
      create: (context) =>
          OtpBloc(authService: di<AuthService>())
            ..add(SendOtp(email: widget.email)),
      child: Scaffold(
        body: BlocConsumer<OtpBloc, OtpState>(
          listener: (context, state) {
            if (state is OtpError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is SuccessSendOtp) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("تم إرسال الرمز بنجاح")),
              );
            } else if (state is OtpIsVerify) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("تم التحقق بنجاح")));
              context.read<UserSessionBloc>().add(LogingUser());
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Center(
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
                            return (value != null && value.length == 6)
                                ? null
                                : 'الرجاء إدخال الرمز بشكل كامل';
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
                              context.read<OtpBloc>().add(
                                VerifyOtp(
                                  email: widget.email,
                                  code: pinController.text,
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
                              onPressed: () {
                                context.read<OtpBloc>().add(
                                  SendOtp(email: widget.email),
                                );
                              },
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
                if (state is OtpLoadingState)
                  Container(
                    color: ColorsApp.yalwoPro,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
