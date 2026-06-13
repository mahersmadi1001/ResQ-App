// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/helper/app_validators.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/TFF.dart';
import 'package:projct/core/widgets/button_auth.dart';
import 'package:projct/view_model/signup_bloc/signup_state.dart';
import 'package:projct/view_model/user_session_bloc/user_session_bloc.dart';
import 'package:projct/viwe/signup/signup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projct/core/config/di.dart';
import 'package:projct/service/auth_service.dart';
import 'package:projct/view_model/login_bloc/login_bloc.dart';
import 'package:projct/view_model/login_bloc/login_event.dart';
import 'package:projct/view_model/login_bloc/login_state.dart';
import 'package:projct/model/login_model.dart';

bool visibility_password = true;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(authService: di<AuthService>()),
      child: Scaffold(
        backgroundColor: ColorsApp.greenPro,
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is LoginSuccessState) {
              context.read<UserSessionBloc>().add(LogingUser());
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Container(
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
                            shadows: [
                              Shadow(blurRadius: 10, offset: Offset(2, 5)),
                            ],
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
                        state is LoadingState
                            ? CircularProgressIndicator()
                            : ButtonAuth(
                                onPressed: () {
                                  if (formLoginKey.currentState!.validate()) {
                                    LoginModel loginModel = LoginModel(
                                      email: emailController!.text,
                                      password: passwordController!.text,
                                    );
                                    context.read<LoginBloc>().add(
                                      SendLogin(loginModel: loginModel),
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
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
                                "Sign up",
                                style: TextStyle(
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10,
                                      offset: Offset(2, 4),
                                    ),
                                  ],
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
              ],
            );
          },
        ),
      ),
    );
  }
}
