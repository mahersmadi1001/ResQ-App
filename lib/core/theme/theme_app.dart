import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.greenPro,
      primary: AppColors.greenPro,
      secondary: AppColors.yellowPro,
      surface: AppColors.backgroundLight,
      onPrimary: AppColors.whitePro,
      onSecondary: AppColors.greenPro,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.greenPro,
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.greenPro),
        titleTextStyle: TextStyle(
          color: AppColors.greenPro,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellowPro,
          foregroundColor: AppColors.greenPro,
          elevation: 2,
          minimumSize: Size(double.infinity, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey.shade100,
        selectedColor: AppColors.greenPro,
        secondarySelectedColor: AppColors.greenPro,
        checkmarkColor: AppColors.yellowPro,
        showCheckmark: true,
        side: BorderSide(color: Colors.grey.shade300, width: 1.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        labelStyle: TextStyle(fontSize: 14.sp, color: AppColors.greenPro),
        secondaryLabelStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.whitePro,
          fontWeight: FontWeight.bold,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.yellowPro,
        linearTrackColor: AppColors.yellowPro.withOpacity(0.2),
        linearMinHeight: 4.h,
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.whitePro,
        modalBackgroundColor: AppColors.whitePro,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
      ),

      extensions: [
        AppContainerTheme(
          primaryCard: BoxDecoration(
            color: AppColors.whitePro,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          inputSurface: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade300),
          ),

          profileHeaderCard: BoxDecoration(
            color: AppColors.whitePro,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.r),
              bottomRight: Radius.circular(40.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.greenPro,
      primary: AppColors.yellowPro,
      secondary: AppColors.greenProLight,
      surface: const Color.fromARGB(255, 49, 49, 49),
      onPrimary: AppColors.greenProDark,
      onSecondary: AppColors.whitePro,
      onSurface: AppColors.whitePro,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.yellowPro,
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: AppColors.whitePro.withOpacity(0.35),
          fontSize: 16.sp,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.whitePro),
        titleTextStyle: TextStyle(
          color: AppColors.whitePro,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellowPro,
          foregroundColor: AppColors.greenProDark,
          elevation: 2,
          minimumSize: Size(double.infinity, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF152D2D),
        selectedColor: AppColors.yellowPro,
        secondarySelectedColor: AppColors.yellowPro,
        checkmarkColor: AppColors.greenProDark,
        showCheckmark: true,
        side: BorderSide(
          color: AppColors.greenProLight.withOpacity(0.4),
          width: 1.w,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        labelStyle: TextStyle(fontSize: 14.sp, color: AppColors.whitePro),
        secondaryLabelStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.greenProDark,
          fontWeight: FontWeight.bold,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.yellowPro,
        linearTrackColor: AppColors.whitePro.withOpacity(0.1),
        linearMinHeight: 4.h,
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: const Color(0xFF122828),
        modalBackgroundColor: const Color(0xFF122828),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
      ),

      extensions: [
        AppContainerTheme(
          primaryCard: BoxDecoration(
            color: const Color(0xff202020),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          inputSurface: BoxDecoration(
            color: AppColors.greenPro,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.greenProLight.withOpacity(0.3)),
          ),

          profileHeaderCard: BoxDecoration(
            color: const Color(0xFF1A2A2A),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.r),
              bottomRight: Radius.circular(40.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: AppColors.yellowPro.withOpacity(0.03),
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AppContainerTheme extends ThemeExtension<AppContainerTheme> {
  final BoxDecoration primaryCard;
  final BoxDecoration inputSurface;
  final BoxDecoration profileHeaderCard;

  const AppContainerTheme({
    required this.primaryCard,
    required this.inputSurface,
    required this.profileHeaderCard,
  });

  @override
  AppContainerTheme copyWith({
    BoxDecoration? primaryCard,
    BoxDecoration? inputSurface,
    BoxDecoration? profileHeaderCard,
  }) {
    return AppContainerTheme(
      primaryCard: primaryCard ?? this.primaryCard,
      inputSurface: inputSurface ?? this.inputSurface,
      profileHeaderCard: profileHeaderCard ?? this.profileHeaderCard,
    );
  }

  @override
  AppContainerTheme lerp(ThemeExtension<AppContainerTheme>? other, double t) {
    if (other is! AppContainerTheme) return this;
    return AppContainerTheme(
      primaryCard:
          BoxDecoration.lerp(primaryCard, other.primaryCard, t) ?? primaryCard,
      inputSurface:
          BoxDecoration.lerp(inputSurface, other.inputSurface, t) ??
          inputSurface,
      profileHeaderCard:
          BoxDecoration.lerp(profileHeaderCard, other.profileHeaderCard, t) ??
          profileHeaderCard,
    );
  }
}

extension AppThemeContextX on BuildContext {
  AppContainerTheme? get containerStyle =>
      Theme.of(this).extension<AppContainerTheme>();

  ColorScheme get colors => Theme.of(this).colorScheme;
}
