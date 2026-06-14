import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:projct/core/constens/constens.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/custom_drawer.dart';
import 'package:projct/core/widgets/munu_two.dart';
import 'package:projct/core/widgets/send_and_midea_button.dart';
import 'package:projct/model/user_model.dart';
import 'package:projct/service/cache_service.dart';

class ReportScreen extends StatefulWidget {
  ReportScreen({super.key});
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  UserModel? user;
  @override
  void initState() {
    // var userbox = Hive.box<UserModel>(CacheService.boxName);
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
            shadows: [
              const Shadow(
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
            SizedBox(height: 35.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 55.h,
                  width: 170.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(35.r),
                      topRight: Radius.circular(35.r),
                    ),
                    color: ColorsApp.greenPro,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            color: ColorsApp.withePro,
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
            SizedBox(height: 62.h),
            Container(
              height: 200.h,
              width: 380.w,
              decoration: BoxDecoration(
                border: Border.all(color: ColorsApp.greenPro, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
              ),
            ),
            SizedBox(height: 60.h),
            AttachmentPickerButton(
              items: ConstensApp.states,
              onSelected: (p0) {},
            ),
            SizedBox(height: 60.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SendAndMideaButton(icon: Icons.send_rounded, ontap: () {}),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.r)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(125),
                        blurRadius: 9,
                        spreadRadius: 1,
                        offset: const Offset(2, 3),
                      ),
                      BoxShadow(
                        color: Colors.white.withAlpha(120),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: const Offset(-2, -3),
                      ),
                    ],
                  ),
                  width: 290.w,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    cursorColor: ColorsApp.yalwoPro,
                    maxLines: 3,
                    minLines: 1,

                    style: TextStyle(
                      color: ColorsApp.withePro,
                      fontSize: 18.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: "Write Here ...",
                      hintStyle: TextStyle(
                        color: ColorsApp.yalwoPro,
                        fontSize: 18.sp,
                      ),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ColorsApp.yalwoPro,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(25.r)),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: ColorsApp.yalwoPro,
                        ),
                      ),
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.image,
                          color: ColorsApp.yalwoPro,
                        ),
                      ),
                      fillColor: ColorsApp.greenPro,

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(25.r)),
                      ),
                    ),
                  ),
                ),

                SendAndMideaButton(ontap: () {}, icon: Icons.mic),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
