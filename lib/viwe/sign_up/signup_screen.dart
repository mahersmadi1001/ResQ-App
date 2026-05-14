import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';

import 'package:projct/core/widgets/ilemnt_page_view.dart';
import 'package:projct/viwe/sign_up/password_componant.dart';
import 'package:projct/viwe/sign_up/signup_componant.dart';

PageController controller_pageviwe = PageController();

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.greenPro,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bace_sinup.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          PageView(
            controller: controller_pageviwe,
            children: [
              IlemntPageView(
                componant: SignUpComponant(),
                hight_contaner: 470.h,
              ),
              IlemntPageView(
                componant: PasswordComponant(),
                hight_contaner: 430.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
