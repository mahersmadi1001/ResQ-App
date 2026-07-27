import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/localization/app_localizations.dart';
import 'package:projct/core/localization/localization_bloc/localization_bloc.dart';
import 'package:projct/core/localization/localization_bloc/localization_event.dart';
import 'package:projct/core/localization/localization_bloc/localization_state.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/constens/constens.dart';
import 'package:projct/core/widgets/logout_dialog.dart';
import 'package:projct/core/widgets/setting_item.dart';
import 'package:projct/viwe/profile/profile_user.dart';
import 'package:projct/viwe/report/report_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (bottomSheetContext) {
        return BlocConsumer<LocalizationBloc, LocalizationState>(
          listener: (context, state) {
            if (state is LocalizationErrorState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMassege)));
            }
          },
          builder: (context, state) {
            bool statesecss = state is LocalizationSuccessState;
            return Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.tr('settings_screen.change_language'),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsApp.greenPro,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  ListTile(
                    title: const Text("العربية"),
                    trailing: statesecss
                        ? state.langCode == Locale("ar")
                              ? Icon(
                                  Icons.check_circle,
                                  color: ColorsApp.greenPro,
                                )
                              : null
                        : null,
                    onTap: () {
                      context.read<LocalizationBloc>().add(
                        const ChangeLanguageEvent('ar'),
                      );
                      Navigator.pop(bottomSheetContext);
                    },
                  ),
                  ListTile(
                    title: const Text("English"),
                    trailing: statesecss
                        ? state.langCode == Locale("en")
                              ? Icon(
                                  Icons.check_circle,
                                  color: ColorsApp.greenPro,
                                )
                              : null
                        : null,
                    onTap: () {
                      context.read<LocalizationBloc>().add(
                        const ChangeLanguageEvent('en'),
                      );
                      Navigator.pop(bottomSheetContext);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250.h,
              child: Stack(
                children: [
                  Container(
                    height: 170.h,
                    decoration: BoxDecoration(
                      border: BorderDirectional(
                        bottom: BorderSide(
                          color: ColorsApp.yalwoPro,
                          width: 4.w,
                        ),
                      ),
                      color: ColorsApp.greenPro,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36.r),
                        bottomRight: Radius.circular(36.r),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorsApp.yalwoPro,
                          width: 4.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(20),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 75.r,
                        backgroundColor: ColorsApp.greenPro,
                        child: Image.asset(
                          ConstensApp.logo,
                          fit: BoxFit.fill,
                          width: 110.w,
                          height: 110.h,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${user?.firstName ?? ""}",
                    style: TextStyle(
                      color: ColorsApp.greenPro,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "${user?.lastName ?? ""}",
                    style: TextStyle(
                      color: ColorsApp.greenPro,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(8),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreenUser(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24.r),
                      ),
                      child: SettingItem(
                        icon: Icons.person_outline_outlined,
                        text: context.tr("settings_screen.profile_details"),
                      ),
                    ),
                    const SettingsDivider(),
                    SettingItem(
                      icon: Icons.notifications_none_outlined,
                      text: context.tr("settings_screen.notifications"),
                    ),
                    const SettingsDivider(),
                    SettingItem(
                      icon: Icons.language_sharp,
                      text: context.tr('general.language'),
                      ontap: () => _showLanguageBottomSheet(context),
                    ),
                    const SettingsDivider(),
                    SettingItem(
                      icon: Icons.dark_mode_outlined,
                      text: context.tr("settings_screen.dark_mode"),
                      switchMode: Switch(
                        value: true,
                        onChanged: (value) {},
                        activeThumbColor: ColorsApp.blackPro,
                        activeTrackColor: ColorsApp.yalwoPro,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(8),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: SettingItem(
                  ontap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const LogoutDialog();
                      },
                    );
                  },
                  icon: Icons.logout,
                  text: context.tr("settings_screen.logout"),
                  colorTextAndIcon: Colors.red.shade400,
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Divider(
        color: const Color(0xfff1f3f5),
        height: 1.h,
        thickness: 1.h,
      ),
    );
  }
}
