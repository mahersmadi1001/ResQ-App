import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/viwe/profile/widget/profile_Information_card.dart';
import 'package:projct/viwe/profile/widget/profileI_dentity_card.dart';

import 'package:projct/viwe/report/report_screen.dart';
import 'package:projct/viwe/profile/widget.dart';

class ProfileScreenUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(backgroundColor: Colors.white, elevation: 0),
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
