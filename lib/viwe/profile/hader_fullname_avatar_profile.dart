import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projct/core/constens/constens.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/theme/theme_app.dart';
import 'package:projct/viwe/profile/widget/profile_logo.dart';

class ProfileHeaderSection extends StatelessWidget {
  final String firstName;
  final String lastName;

  const ProfileHeaderSection({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: context.containerStyle?.profileHeaderCard,
      child: Column(
        children: [
          const ProfileLogoTopBar(),
          SizedBox(height: 24.h),
          const ProfilePremiumAvatarPlaceholder(),
          SizedBox(height: 16.h),
          ProfileUserFullName(firstName: firstName, lastName: lastName),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}

class ProfilePremiumAvatarPlaceholder extends StatelessWidget {
  const ProfilePremiumAvatarPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.r,
      height: 140.r,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.yellowPro, width: 3.w),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.greenPro, AppColors.greenPro.withOpacity(0.85)],
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(10.r),
        child: Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Hero(
            tag: 1,
            child: SvgPicture.asset(ConstensApp.logo, fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }
}

class ProfileUserFullName extends StatelessWidget {
  final String firstName;
  final String lastName;

  const ProfileUserFullName({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            firstName,
            style: TextStyle(
              color: AppColors.greenPro,
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            " $lastName",
            style: TextStyle(
              color: AppColors.yellowPro,
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
