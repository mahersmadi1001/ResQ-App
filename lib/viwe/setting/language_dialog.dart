import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/localization/app_localizations.dart';
import 'package:projct/core/localization/localization_bloc/localization_bloc.dart';
import 'package:projct/core/localization/localization_bloc/localization_event.dart';
import 'package:projct/core/localization/localization_bloc/localization_state.dart';
import 'package:projct/core/theme/colors_app.dart';

void showLanguageBottomSheet(BuildContext context) {
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
                    color: AppColors.greenPro,
                  ),
                ),
                SizedBox(height: 15.h),
                ListTile(
                  title: const Text("العربية"),
                  trailing: statesecss
                      ? state.langCode == Locale("ar")
                            ? Icon(
                                Icons.check_circle,
                                color: AppColors.greenPro,
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
                                color: AppColors.greenPro,
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
