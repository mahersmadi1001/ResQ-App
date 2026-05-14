// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/helper/app_validators.dart';
import 'package:projct/core/theme/colors_app.dart';

import 'package:projct/core/widgets/TFF.dart';
import 'package:projct/core/widgets/button_auth.dart';

import 'package:projct/viwe/sign_up/signup_screen.dart';
import 'package:projct/viwe/bottom_nav_bar.dart';

bool visibility_password = true;

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.greenPro,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bace_login.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: formLoginKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 210.h),

              Text(
                "Login",
                style: TextStyle(
                  shadows: [Shadow(blurRadius: 10, offset: Offset(2, 5))],
                  color: ColorsApp.yalwoPro,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 45.h),
              Tff(
                controller: emailController,
                validator: (p1) {
                  return AppValidators.validateEmail(p1);
                },
                label: "Email",
                suffixIcon: null,
                prefixIcon: null,
              ),
              SizedBox(height: 30.h),
              Tff(
                controller: passwordController,
                obscureText: visibility_password,
                validator: (p0) {
                  return AppValidators.validatePassword(p0);
                },
                label: "Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    visibility_password
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      visibility_password = !visibility_password;
                    });
                  },
                  color: ColorsApp.yalwoPro,
                ),
              ),
              SizedBox(height: 30.h),
              ButtonAuth(
                onPressed: () {
                  if (formLoginKey.currentState!.validate()) {
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
              SizedBox(height: 18.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "If you don't have an account :",
                    style: TextStyle(color: Colors.white, fontSize: 15.sp),
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
                      "Sign up",
                      style: TextStyle(
                        shadows: [Shadow(blurRadius: 10, offset: Offset(2, 4))],
                        color: ColorsApp.yalwoPro,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
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
