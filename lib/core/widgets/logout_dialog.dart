import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/localization/app_localizations.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/view_model/user_session_bloc/user_session_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projct/core/config/di.dart';
import 'package:projct/service/auth_service.dart';
import 'package:projct/view_model/logout_bloc/logout_bloc.dart';
import 'package:projct/view_model/logout_bloc/logout_event.dart';
import 'package:projct/view_model/logout_bloc/logout_state.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoutBloc(authService: di<AuthService>()),
      child: BlocConsumer<LogoutBloc, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            context.read<UserSessionBloc>().add(Signout());
            Navigator.pop(context);
          } else if (state is LogoutErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return AlertDialog(
            icon: Icon(
              Icons.error_outline_rounded,
              color: Colors.red.shade600,
              size: 50.sp,
            ),
            scrollable: true,
            backgroundColor: Colors.white,
            content: Text(
              context.tr("settings_screen.logout_confirm_body"),
              style: TextStyle(color: ColorsApp.yalwoPro, fontSize: 20.sp),
            ),
            title: Text(
              context.tr("settings_screen.logout"),
              style: TextStyle(color: Colors.red),
            ),
            actions: [
              Row(
                spacing: 20.w,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withAlpha(200),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      context.tr("general.cancel"),
                      style: const TextStyle(color: ColorsApp.yalwoPro),
                    ),
                  ),
                  state is LogoutLoadingState
                      ? const CircularProgressIndicator(
                          color: ColorsApp.yalwoPro,
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsApp.greenPro,
                          ),
                          onPressed: () {
                            context.read<LogoutBloc>().add(SendLogout());
                          },
                          child: Text(
                            context.tr("general.yes"),
                            style: const TextStyle(color: ColorsApp.yalwoPro),
                          ),
                        ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
