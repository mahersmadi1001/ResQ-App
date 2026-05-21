import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/helper/app_validators.dart';
import 'package:projct/core/theme/colors_app.dart';

import 'package:projct/core/widgets/TFF.dart';
import 'package:projct/core/widgets/button_auth.dart';
import 'package:projct/core/widgets/chips_address.dart';
import 'package:projct/core/widgets/navegator_login.dart';
import 'package:projct/viwe/sign_up/signup_screen.dart'
    show controller_pageviwe;

class SignUpComponant extends StatefulWidget {
  SignUpComponant({super.key, this.onDataSaved});
  final Function({
    required String firstName,
    required String lastName,
    required String id,
    required String address,
    required IdentityType identityType,
  })?
  onDataSaved;
  @override
  State<SignUpComponant> createState() => _SignUpComponantState();
}

class _SignUpComponantState extends State<SignUpComponant> {
  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? lasttNameController = TextEditingController();
  TextEditingController? idController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(height: 7.h),
          Text(
            "Sign Up",
            style: TextStyle(
              shadows: [Shadow(blurRadius: 10, offset: Offset(2, 5))],
              color: ColorsApp.yalwoPro,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 27.h),
          Expanded(
            child: Tff(
              controller: firstNameController,
              validator: (p0) {
                return AppValidators.validateName(p0);
              },
              label: "First Name",
            ),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: Tff(
              controller: lasttNameController,
              validator: (p0) {
                return AppValidators.validateName(p0);
              },
              label: "Last Name",
            ),
          ),
          SizedBox(height: 10.h),

          Expanded(
            child: Tff(
              controller: idController,
              validator: (p0) {
                return AppValidators.validateIDOrPassport(p0);
              },
              label: "National ID or Passport",
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              SizedBox(width: 27.w),
              Text(
                "Address :",
                style: TextStyle(
                  shadows: [Shadow(blurRadius: 10, offset: Offset(6, 3))],
                  color: ColorsApp.yalwoPro,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 18.w),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: ColorsApp.yalwoPro, width: 2),
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(16.r)),
                ),

                height: 46.h,
                minWidth: 240.w,
                onPressed: () {
                  showModalBottomSheet(
                    isDismissible: true,
                    backgroundColor: ColorsApp.withePro,
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 375.h,
                        child: Center(child: ListAddress()),
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: ColorsApp.yalwoPro,
                      size: 28.sp,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "Specify your Address",
                      style: TextStyle(
                        color: ColorsApp.yalwoPro,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 27.h),
          ButtonAuth(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (widget.onDataSaved != null) {
                  widget.onDataSaved!(
                    firstName: firstNameController!.text,
                    lastName: lasttNameController!.text,
                    id: idController!.text,
                    address: ListAddress.selectedAddress ?? "",
                    identityType: AppValidators.getIdentityType(
                      idController!.text,
                    ),
                  );
                }

                controller_pageviwe.animateToPage(
                  1,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                );
              }
            },
            textButton: "Next",
          ),
          SizedBox(height: 17.h),
          NavigatToLogin(),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
