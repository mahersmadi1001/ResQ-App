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
import 'package:projct/view_model/report_input_bloc/report_input_event.dart';
import 'package:projct/viwe/report/widgets/report_input_area.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projct/view_model/report_input_bloc/report_input_bloc.dart';

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
      body: BlocProvider(
        create: (context) => ReportInputBloc(),
        child: Builder(
          builder: (context) {
            return SizedBox(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
            );
          },
        ),
      ),
    );
  }
}
