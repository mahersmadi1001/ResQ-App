import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:projct/core/constens/constens.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/BoxSendReport.dart';
import 'package:projct/core/widgets/custom_drawer.dart';
import 'package:projct/core/widgets/new_munu.dart';
import 'package:projct/core/widgets/send_button.dart';
import 'package:projct/model/user_model.dart';
import 'package:projct/service/cache_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projct/view_model/media_picker_bloc/media_picker_bloc.dart';
import 'package:projct/viwe/widgets/media_picker_sheet.dart';

UserModel? user;

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  @override
  void initState() {
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
      body: SizedBox(
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
                          NewMunu(),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.mic,
                        color: Colors.grey.shade700,
                        size: 28.sp,
                      ),
                    ),
                  ),

                  Container(
                    width: 260.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25.r)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      cursorColor: ColorsApp.greenPro,
                      maxLines: 3,
                      minLines: 1,
                      style: TextStyle(color: Colors.black87, fontSize: 16.sp),
                      decoration: InputDecoration(
                        hintText: "Write Here ...",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 16.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),

                        prefixIcon: IconButton(
                          onPressed: () async {
                            final selectedMedia = await showModalBottomSheet<List<AssetEntity>>(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.7,
                                  child: BlocProvider(
                                    create: (context) => MediaPickerBloc(),
                                    child: MediaPickerSheet(),
                                  ),
                                );
                              },
                            );

                            if (selectedMedia != null && selectedMedia.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("تم اختيار ${selectedMedia.length} مرفقات")),
                              );
                            }
                          },
                          icon: Icon(
                            Icons.attach_file_outlined,
                            color: ColorsApp.greenPro.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SendButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
