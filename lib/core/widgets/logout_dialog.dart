import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/config/di.dart';
import 'package:projct/core/localization/app_localizations.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/circular_progress.dart';
import 'package:projct/service/auth_service.dart';
import 'package:projct/service/cache_service.dart';
import 'package:projct/view_model/logout_bloc/logout_bloc.dart';
import 'package:projct/view_model/logout_bloc/logout_event.dart';
import 'package:projct/view_model/logout_bloc/logout_state.dart';
import 'package:projct/view_model/user_session_bloc/user_session_bloc.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => LogoutBloc(authService: di<AuthService>()),
      child: BlocConsumer<LogoutBloc, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            context.read<UserSessionBloc>().add(Signout());
            di<CacheService>().deleteLanguage();
            Navigator.pop(context);
          } else if (state is LogoutErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red.shade600,
              ),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
            ),
            backgroundColor: theme.dialogBackgroundColor,
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50.withOpacity(isDark ? 0.1 : 0.8),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.logout_rounded,
                      color: Colors.red.shade400,
                      size: 36.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  Text(
                    context.tr("settings_screen.logout"),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),

                  Text(
                    context.tr("settings_screen.logout_confirm_body"),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            side: BorderSide(
                              color: isDark
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            context.tr("general.cancel"),
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? Colors.grey.shade300
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),

                      Expanded(
                        child: state is LogoutLoadingState
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: const CircularPro(),
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  backgroundColor: AppColors.greenPro,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                onPressed: () {
                                  context.read<LogoutBloc>().add(SendLogout());
                                },
                                child: Text(
                                  context.tr("general.yes"),
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.yellowPro,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
