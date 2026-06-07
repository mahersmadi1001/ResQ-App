import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/custom_drawer.dart';
import 'package:projct/core/widgets/munu_two.dart';
import 'package:projct/core/widgets/send_and_midea_button.dart';
import 'package:projct/model/item_munu_modal.dart';

class RebortScreen extends StatefulWidget {
  const RebortScreen({super.key});
  @override
  State<RebortScreen> createState() => _RebortScreenState();
}

class _RebortScreenState extends State<RebortScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
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
          "Rebort Page",
          style: TextStyle(
            shadows: [
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
            SizedBox(height: 70.h),
            Container(
              height: 300.h,
              width: 380.w,
              decoration: BoxDecoration(
                border: Border.all(color: ColorsApp.greenPro, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
              ),
            ),
            SizedBox(height: 60.h),
            AttachmentPickerButton(items: teams, onSelected: (p0) {}),
            SizedBox(height: 40.h),
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SendAndMideaButton(
                      icon: Icons.send_rounded,
                      ontap: () {},
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25.r)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(125),
                          blurRadius: 9,
                          spreadRadius: 1,
                          offset: Offset(2, 3),
                        ),
                        BoxShadow(
                          color: Colors.white.withAlpha(120),
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: Offset(-2, -3),
                        ),
                      ],
                    ),
                    width: 290.w,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      cursorColor: ColorsApp.yalwoPro,
                      maxLines: null,
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
                          borderSide: BorderSide(
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
                          icon: Icon(Icons.image, color: ColorsApp.yalwoPro),
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
                  SizedBox(width: 6.w),
                  Expanded(
                    child: SendAndMideaButton(ontap: () {}, icon: Icons.mic),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }
}
