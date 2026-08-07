import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/helper/app_validators.dart';
import 'package:projct/core/theme/colors_app.dart';

import 'package:projct/core/widgets/ilemnt_page_view.dart';
import 'package:projct/viwe/signup/password_componant.dart';
import 'package:projct/viwe/signup/signup_componant.dart';

PageController controller_pageviwe = PageController();

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? storedFirstName;
  String? storedLastName;
  String? storedId;
  String? storedAddress;
  IdentityType? storedIdentityType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenPro,
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
          PageView.builder(
            allowImplicitScrolling: false,
            controller: controller_pageviwe,
            itemCount: 2,
            onPageChanged: (index) {
              setState(() {});
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                return IlemntPageView(
                  componant: SignUpComponant(
                    onDataSaved:
                        ({
                          required String firstName,
                          required String lastName,
                          required String id,
                          required String address,
                          required IdentityType identityType,
                        }) {
                          storedFirstName = firstName;
                          storedLastName = lastName;
                          storedId = id;
                          storedAddress = address;
                          storedIdentityType = identityType;
                        },
                  ),
                  hight_contaner: 490.h,
                );
              } else {
                return IlemntPageView(
                  componant: PasswordComponant(
                    id: storedId,
                    firstName: storedFirstName,
                    lasttName: storedLastName,
                    address: storedAddress,
                    identityType: storedIdentityType?.name,
                  ),
                  hight_contaner: 480.h,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
