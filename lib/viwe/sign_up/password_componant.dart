import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/config/di.dart';
import 'package:projct/core/helper/app_validators.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/model/sign_up_model.dart';

import 'package:projct/core/widgets/TFF.dart';
import 'package:projct/core/widgets/button_auth.dart';
import 'package:projct/core/widgets/navegator_login.dart' show NavigatToLogin;
import 'package:projct/core/widgets/signUp_title.dart';

import 'package:projct/service/auth_service.dart';
import 'package:projct/view_model/signup_bloc/signup_bloc.dart';
import 'package:projct/view_model/signup_bloc/signup_event.dart';
import 'package:projct/view_model/signup_bloc/signup_state.dart';

import 'package:projct/viwe/otp_page.dart';

import 'package:projct/viwe/sign_up/signup_screen.dart'
    show controller_pageviwe;

class PasswordComponant extends StatefulWidget {
  PasswordComponant({
    required this.id,
    required this.firstName,
    required this.lasttName,
    required this.address,
    required this.identityType,
  });
  final String? identityType;
  final String? address;
  final String? firstName;
  final String? lasttName;

  final String? id;
  @override
  State<PasswordComponant> createState() => _PasswordComponantState();
}

class _PasswordComponantState extends State<PasswordComponant> {
  TextEditingController? emailsignController = TextEditingController();
  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  TextEditingController? newPasswordController = TextEditingController();
  TextEditingController? validPasswordController = TextEditingController();
  bool visibility_password = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(authService: AuthService()),
      child: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SucssfoledState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return OtpScreen(email: emailsignController!.text);
                },
              ),
            );
          } else if (state is ErorrState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.ErorrMassege),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<SignupBloc, SignupState>(
          builder: (context, state) {
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
                      return null;
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
                      state is LoadingState
                          ? CircularProgressIndicator()
                          : ButtonAuth(
                              onPressed: () {
                                if (form_key.currentState!.validate()) {
                                  if (emailsignController!.text.isNotEmpty &&
                                      newPasswordController!.text.isNotEmpty &&
                                      validPasswordController!
                                          .text
                                          .isNotEmpty) {
                                    final signUpModel = SignUpModel(
                                      firstName: widget.firstName!,
                                      lastName: widget.lasttName!,
                                      email: emailsignController!.text,
                                      address: widget.address!,
                                      officialIdentifier: widget.id!,
                                      officialIdentifierMethod:
                                          widget.identityType!,
                                      password: newPasswordController!.text,
                                      passwordConfirmation:
                                          validPasswordController!.text,
                                    );
                                    print(signUpModel);
                                    context.read<SignupBloc>().add(
                                      SendSigup(signUpModel: signUpModel),
                                    );
                                  }
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
          },
        ),
      ),
    );
  }
}
