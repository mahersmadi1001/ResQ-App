import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/helper/app_validators.dart';
import 'package:projct/core/theme/colors_app.dart';

import 'package:projct/core/widgets/TFF.dart';
import 'package:projct/core/widgets/button_auth.dart';
import 'package:projct/core/widgets/navegator_login.dart' show NavigatToLogin;
import 'package:projct/core/widgets/signUp_title.dart';

import 'package:projct/viwe/login_screen.dart';
import 'package:projct/viwe/otp_page.dart';

import 'package:projct/viwe/sign_up/signup_screen.dart';

TextEditingController? emailsignController = TextEditingController();

class PasswordComponant extends StatefulWidget {
  PasswordComponant({
    this.id = "",
    this.firstName = "",
    this.lasttName = "",
    this.address = "",
  });
  final String address;
  final String firstName;
  final String lasttName;

  final String id;
  @override
  State<PasswordComponant> createState() => _PasswordComponantState();
}

class _PasswordComponantState extends State<PasswordComponant> {
  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  TextEditingController? newPasswordController = TextEditingController();
  TextEditingController? validPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form_key,
      child: Column(
        children: [
          SizedBox(height: 17.h),
          SignUpTitle(),
          SizedBox(height: 27.h),
          Tff(
            controller: emailsignController,
            validator: (p0) {
              return AppValidators.validateEmail(p0);
            },
            label: "Email",
          ),
          SizedBox(height: 27.h),
          Tff(
            controller: newPasswordController,
            validator: (p0) {
              return AppValidators.validatePassword(p0);
            },
            label: "Create Password",
            obscureText: visibility_password,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  visibility_password = !visibility_password;
                });
              },
              icon: Icon(
                color: ColorsApp.yalwoPro,
                visibility_password
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_outlined,
              ),
            ),
          ),
          SizedBox(height: 27.h),
          Tff(
            controller: validPasswordController,
            validator: (p0) {
              if (p0 != newPasswordController!.text) {
                return "يجب ان تتطابق كلمة السر";
              }
            },
            label: "Validat Password",
            obscureText: visibility_password,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  visibility_password = !visibility_password;
                });
              },
              icon: Icon(
                color: ColorsApp.yalwoPro,
                visibility_password
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_outlined,
              ),
            ),
          ),
          SizedBox(height: 27.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonAuth(
                onPressed: () {
                  controller_pageviwe.animateToPage(
                    0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                },
                textButton: "returning",
                minWidth: 120.w,
              ),
              ButtonAuth(
                onPressed: () {
                  if (form_key.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return OtpScreen();
                        },
                      ),
                    );
                  }
                },
                textButton: "register",
                minWidth: 120.w,
              ),
            ],
          ),
          SizedBox(height: 17.h),
          NavigatToLogin(),
        ],
      ),
    );
  }
}
