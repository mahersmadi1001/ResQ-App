import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:projct/core/config/di.dart';
import 'package:projct/core/constens/constens.dart';
import 'package:projct/core/localization/app_localizations.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/BoxSendReport.dart';
import 'package:projct/core/widgets/new_munu.dart';
import 'package:projct/model/user_model.dart';
import 'package:projct/service/cache_service.dart';
import 'package:projct/service/refresh_token_service.dart';
import 'package:projct/view_model/report_input_bloc/report_input_bloc.dart';
import 'package:projct/view_model/report_input_bloc/report_input_event.dart';
import 'package:projct/view_model/send_report_bloc/send_report_bloc.dart';
import 'package:projct/view_model/send_report_bloc/send_report_state.dart';
import 'package:projct/viwe/report/widgets/dialog_steps.dart';
import 'package:projct/viwe/report/widgets/report_input_area.dart';

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
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.r),
            bottomRight: Radius.circular(15.r),
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.greenPro,
        title: Text(
          context.tr('report_screen.report_page'),
          style: TextStyle(
            shadows: const [
              Shadow(
                color: Colors.black87,
                blurRadius: 7,
                offset: Offset(2, 4),
              ),
            ],
            fontSize: 23.sp,
            color: AppColors.yellowPro,
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
                  context.read<ReportInputBloc>().add(ClearInput());
                  NewMunu.selectedItems.clear();
                  setState(() {});
                  showSuccessDialog(context, state.responseData);
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
                                    borderRadius:
                                        AppLocalizations.currentLanguage == "en"
                                        ? BorderRadius.only(
                                            bottomRight: Radius.circular(35.r),
                                            topRight: Radius.circular(35.r),
                                          )
                                        : BorderRadius.only(
                                            bottomLeft: Radius.circular(35.r),
                                            topLeft: Radius.circular(35.r),
                                          ),
                                    color: Color(0xffe8e4da),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          context.tr('report_screen.welcome'),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.greenPro,
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                        Text(
                                          " ${user?.firstName ?? ""}",
                                          style: TextStyle(
                                            color: AppColors.yellowPro,
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
                                        "${context.tr('report_screen.incident_types')} ",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.greenPro,
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
                          ],
                        ),
                      ),
                    ),

                    const ReportInputArea(),
                    SizedBox(height: 25.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
