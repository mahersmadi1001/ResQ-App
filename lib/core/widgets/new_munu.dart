import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/constens/constens.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/model/item_munu_modal.dart';
import 'package:projct/view_model/report_input_bloc/report_input_bloc.dart';
import 'package:projct/view_model/report_input_bloc/report_input_event.dart';

class NewMunu extends StatefulWidget {
  NewMunu({super.key});
  static final List<AttachmentItem> selectedItems = [];
  @override
  State<NewMunu> createState() => _NewMunuState();
}

class _NewMunuState extends State<NewMunu> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.r),
      onTap: () {
        print("${NewMunu.selectedItems.toString()}");
        showModalBottomSheet(
          isDismissible: false,
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          builder: (context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 15.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(),
                      Wrap(
                        spacing: 10.w,
                        runSpacing: 10.h,
                        alignment: WrapAlignment.center,
                        children: ConstensApp.states.map((item) {
                          final bool isSelected = NewMunu.selectedItems
                              .contains(item);

                          return GestureDetector(
                            onTap: () {
                              setModalState(() {
                                if (isSelected) {
                                  // context.read<ReportInputBloc>().add(
                                  //   SelecteOption(
                                  //     Options: NewMunu.selectedItems,
                                  //   ),
                                  // );
                                  NewMunu.selectedItems.remove(item);
                                } else {
                                  // context.read<ReportInputBloc>().add(
                                  //   SelecteOption(
                                  //     Options: NewMunu.selectedItems,
                                  //   ),
                                  // );
                                  NewMunu.selectedItems.add(item);
                                }
                              });
                            },
                            child: SizedBox(
                              width: 85.w,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(3.r),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? ColorsApp.yalwoPro
                                            : Colors.transparent,
                                        width: 2.5.w,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 30.r,
                                      backgroundColor: ColorsApp.greenPro
                                          .withAlpha(240),
                                      child: Icon(
                                        item.icon,
                                        color: ColorsApp.yalwoPro,
                                        size: 28.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      color: ColorsApp.greenPro,
                                      fontSize: 13.sp,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 30.h),

                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);

                          setState(() {});
                        },
                        color: ColorsApp.greenPro,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                          side: BorderSide(
                            color: ColorsApp.yalwoPro,
                            width: 2.w,
                          ),
                        ),
                        minWidth: 200.w,
                        height: 50.h,
                        child: Text(
                          "تأكيد الاختيار",
                          style: TextStyle(
                            color: ColorsApp.yalwoPro,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: NewMunu.selectedItems.isNotEmpty
              ? ColorsApp.greenPro.withOpacity(0.13)
              : Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: NewMunu.selectedItems.isNotEmpty
                ? ColorsApp.greenPro
                : Colors.red.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              NewMunu.selectedItems.isNotEmpty
                  ? "States Selected Successfully"
                  : "Select Incident Types...",
              style: TextStyle(
                color: NewMunu.selectedItems.isNotEmpty
                    ? ColorsApp.greenPro
                    : Colors.grey.shade500,
                fontSize: 16.sp,
                fontWeight: NewMunu.selectedItems.isNotEmpty
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            Icon(
              NewMunu.selectedItems.isNotEmpty
                  ? Icons.check_circle_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: NewMunu.selectedItems.isNotEmpty
                  ? ColorsApp.greenPro
                  : Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
