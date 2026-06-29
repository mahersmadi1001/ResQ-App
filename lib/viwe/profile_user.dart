import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/constens/constens.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/model/user_model.dart';
import 'package:projct/viwe/report/report_screen.dart';

class ProfileScreenUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: ProfileStatusBar(),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            ProfileHeaderSection(
              firstName: user!.firstName,
              lastName: user!.lastName,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 32.h),
                      ProfileIdentityCard(
                        method: user!.officialIdentifierMethod,
                        identifier: user!.officialIdentifier,
                      ),
                      SizedBox(height: 20.h),
                      ProfileInformationCard(
                        firstName: user!.firstName,
                        lastName: user!.lastName,
                        email: user!.email,
                      ),
                      SizedBox(height: 40.h),
                      // const ProfileFooterBranding(),
                      // SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileStatusBar extends StatelessWidget {
  const ProfileStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: Colors.white, elevation: 0);
  }
}

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
      decoration: BoxDecoration(
        color: Colors.white,
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

class ProfileLogoTopBar extends StatelessWidget {
  const ProfileLogoTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsApp.greenPro,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25.r),
          bottomRight: Radius.circular(25.r),
        ),
      ),
      // color: ColorsApp.greenPro,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: ColorsApp.withePro,
                    size: 20.sp,
                  ),
                ),
                Text(
                  "Account Profile",
                  style: TextStyle(
                    color: ColorsApp.yalwoPro,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(width: 48.w),
              ],
            ),
          ),
          SizedBox(height: 10.h),
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
        border: Border.all(color: ColorsApp.yalwoPro, width: 3.w),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ColorsApp.greenPro, ColorsApp.greenPro.withOpacity(0.85)],
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(8.r),
        child: Image.asset(ConstensApp.logo, fit: BoxFit.contain),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstName,
          style: TextStyle(
            color: ColorsApp.greenPro,
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          " $lastName",
          style: TextStyle(
            color: ColorsApp.yalwoPro,
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ProfileIdentityCard extends StatelessWidget {
  final String method;
  final String identifier;

  const ProfileIdentityCard({
    super.key,
    required this.method,
    required this.identifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorsApp.greenPro,
            Color.alphaBlend(
              Colors.black.withOpacity(0.15),
              ColorsApp.greenPro,
            ),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: ColorsApp.greenPro.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20.w,
            top: -20.h,
            child: CircleAvatar(
              radius: 60.r,
              backgroundColor: Colors.white.withOpacity(0.03),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "OFFICIAL IDENTIFICATION",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorsApp.yalwoPro.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          color: ColorsApp.yalwoPro.withOpacity(0.5),
                          width: 1.w,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.verified_user_rounded,
                            color: ColorsApp.yalwoPro,
                            size: 12.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "SECURED",
                            style: TextStyle(
                              color: ColorsApp.yalwoPro,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  method.toUpperCase(),
                  style: TextStyle(
                    color: ColorsApp.yalwoPro,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  identifier,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: ColorsApp.withePro, width: 1.5.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "PERSONAL DETAILS",
            style: TextStyle(
              color: ColorsApp.greenPro.withOpacity(0.4),
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 16.h),
          ProfileInfoRow(
            icon: Icons.person_outline_rounded,
            label: "First Name",
            value: firstName,
          ),
          ProfileInfoDivider(),
          ProfileInfoRow(
            icon: Icons.person_outline_rounded,
            label: "Last Name",
            value: lastName,
          ),
          ProfileInfoDivider(),
          ProfileInfoRow(
            icon: Icons.alternate_email_rounded,
            label: "Email Address",
            value: email,
          ),
        ],
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: ColorsApp.greenPro.withOpacity(0.06),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: ColorsApp.greenPro, size: 20.sp),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(
                  color: ColorsApp.yalwoPro,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileInfoDivider extends StatelessWidget {
  const ProfileInfoDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Divider(color: Colors.grey.shade100, height: 1.h, thickness: 1.h),
    );
  }
}

// class ProfileFooterBranding extends StatelessWidget {
//   const ProfileFooterBranding({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Opacity(
//       opacity: 0.25,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.shield_rounded, color: ColorsApp.greenPro, size: 16.sp),
//           SizedBox(width: 6.w),
//           Text(
//             "Encrypted & Protected System",
//             style: TextStyle(
//               color: ColorsApp.greenPro,
//               fontSize: 11.sp,
//               fontWeight: FontWeight.w600,
//               letterSpacing: 0.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
