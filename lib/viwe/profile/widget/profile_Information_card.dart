import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/localization/app_localizations.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/theme/theme_app.dart';
import 'package:projct/viwe/profile/widget/profile_Info_row.dart';

class ProfileInformationCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;

  const ProfileInformationCard({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: context.containerStyle?.primaryCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr("profile_screen.personal_details"),
            style: TextStyle(
              color: AppColors.greenProLight,
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 16.h),
          ProfileInfoRow(
            icon: Icons.person_outline_rounded,
            label: context.tr("profile_screen.first_name"),
            value: firstName,
          ),
          ProfileInfoRow(
            icon: Icons.person_outline_rounded,
            label: context.tr("profile_screen.last_name"),
            value: lastName,
          ),
          ProfileInfoRow(
            icon: Icons.alternate_email_rounded,
            label: context.tr("profile_screen.email_address"),
            value: email,
          ),
        ],
      ),
    );
  }
}
