import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:projct/core/config/di.dart';
import 'package:projct/core/constens/constens.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/BoxSendReport.dart';
import 'package:projct/core/widgets/custom_drawer.dart';
import 'package:projct/core/widgets/new_munu.dart';
import 'package:projct/model/user_model.dart';
import 'package:projct/service/cache_service.dart';
import 'package:projct/service/refresh_token_service.dart';
import 'package:projct/view_model/report_input_bloc/report_input_bloc.dart';
import 'package:projct/view_model/report_input_bloc/report_input_event.dart';
import 'package:projct/view_model/send_report_bloc/send_report_bloc.dart';
import 'package:projct/view_model/send_report_bloc/send_report_state.dart';
import 'package:projct/viwe/report/widgets/report_input_area.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

UserModel? user;

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    RefreshTokenService refresh = RefreshTokenService(
      cacheService: di<CacheService>(),
    );
    refresh.refreshToken();
    user = Hive.box(CacheService.boxName).get(CacheService.userKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.r),
            bottomRight: Radius.circular(15.r),
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorsApp.greenPro,
        title: Text(
          "Report Page",
          style: TextStyle(
            shadows: const [
              Shadow(
                color: Colors.black87,
                blurRadius: 7,
                offset: Offset(2, 4),
              ),
            ],
            fontSize: 23.sp,
            color: ColorsApp.yalwoPro,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ReportInputBloc()),
          BlocProvider(create: (context) => SendReportBloc()),
        ],
        child: Builder(
          builder: (context) {
            return BlocListener<SendReportBloc, SendReportState>(
              listener: (context, state) {
                if (state is SendReportSuccess) {
                  // Clear entire input
                  context.read<ReportInputBloc>().add(ClearInput());
                  NewMunu.selectedItems.clear();
                  _showSuccessDialog(context, state.responseData);
                } else if (state is SendReportFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.white),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              state.error,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 35.h),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 55.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(35.r),
                                      topRight: Radius.circular(35.r),
                                    ),
                                    color: ColorsApp.yalwoPro.withOpacity(0.25),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Welcome",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: ColorsApp.greenPro,
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                        Text(
                                          " ${user?.firstName ?? ""}",
                                          style: TextStyle(
                                            color: ColorsApp.yalwoPro,
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 40.h),

                            BoxTextRepot(statment: ConstensApp.statment),

                            SizedBox(height: 40.h),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Incident Types ",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsApp.greenPro,
                                        ),
                                      ),
                                      Text(
                                        "*",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  NewMunu(
                                    onSelectionChanged: (selectedItems) {
                                      context.read<ReportInputBloc>().add(
                                        IncidentTypesChanged(selectedItems),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ),

                    const ReportInputArea(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, Map<String, dynamic> data) {
    final advice = data['advice'];
    final address = data['address'];

    final title = advice?['title'] ?? 'تم الإرسال بنجاح';
    final steps = advice?['steps'] as List<dynamic>? ?? [];
    final street = address?['street'] ?? '';
    final city = address?['city'] ?? '';
    final governorate = address?['governorate'] ?? '';
    final addressText = [
      street,
      city,
      governorate,
    ].where((s) => s.isNotEmpty).join('، ');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorsApp.greenPro,
                ColorsApp.greenPro.withOpacity(0.85),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: ColorsApp.greenPro.withOpacity(0.5),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 24.h),
                decoration: BoxDecoration(
                  color: ColorsApp.yalwoPro.withOpacity(0.15),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(14.r),
                      decoration: BoxDecoration(
                        color: ColorsApp.yalwoPro,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorsApp.yalwoPro.withOpacity(0.4),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        color: ColorsApp.greenPro,
                        size: 36.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (addressText.isNotEmpty) ...[
                      SizedBox(height: 6.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: ColorsApp.yalwoPro,
                            size: 16.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            addressText,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Steps
              if (steps.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'إرشادات السلامة:',
                        style: TextStyle(
                          color: ColorsApp.yalwoPro,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ...steps.asMap().entries.map((entry) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 22.w,
                                height: 22.w,
                                decoration: BoxDecoration(
                                  color: ColorsApp.yalwoPro,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${entry.key + 1}',
                                    style: TextStyle(
                                      color: ColorsApp.greenPro,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  entry.value.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),

              // Close Button
              Padding(
                padding: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsApp.yalwoPro,
                      foregroundColor: ColorsApp.greenPro,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      'حسناً',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
