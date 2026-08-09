import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/constens/constens.dart';
import 'package:projct/core/localization/app_localizations.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/model/item_munu_modal.dart';

class NewMunu extends StatefulWidget {
  final ValueChanged<List<AttachmentItem>>? onSelectionChanged;

  NewMunu({super.key, this.onSelectionChanged});
  static final List<AttachmentItem> selectedItems = [];
  @override
  State<NewMunu> createState() => _NewMunuState();
}

class _NewMunuState extends State<NewMunu> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onSelectionChanged != null) {
        widget.onSelectionChanged!(List.from(NewMunu.selectedItems));
      }
    });
  }

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
                                  NewMunu.selectedItems.remove(item);
                                } else {
                                  NewMunu.selectedItems.add(item);
                                }
                                if (widget.onSelectionChanged != null) {
                                  widget.onSelectionChanged!(
                                    List.from(NewMunu.selectedItems),
                                  );
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
                                            ? AppColors.yellowPro
                                            : Colors.transparent,
                                        width: 2.5.w,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 30.r,
                                      backgroundColor: AppColors.greenPro
                                          .withAlpha(240),
                                      child: Icon(
                                        item.icon,
                                        color: AppColors.yellowPro,
                                        size: 28.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      color: AppColors.greenPro,
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
                          if (widget.onSelectionChanged != null) {
                            widget.onSelectionChanged!(
                              List.from(NewMunu.selectedItems),
                            );
                          }
                          Navigator.pop(context);

                          setState(() {});
                        },
                        color: AppColors.greenPro,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                          side: BorderSide(
                            color: AppColors.yellowPro,
                            width: 2.w,
                          ),
                        ),
                        minWidth: 200.w,
                        height: 50.h,
                        child: Text(
                          context.tr('general.confirm_selection'),
                          style: TextStyle(
                            color: AppColors.yellowPro,
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
              ? Color(0xffdbe2e2)
              : Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: NewMunu.selectedItems.isNotEmpty
                ? AppColors.greenPro
                : Colors.red.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              NewMunu.selectedItems.isNotEmpty
                  ? context.tr('report_screen.states_selected_successfully')
                  : context.tr('report_screen.select_incident_types'),
              style: TextStyle(
                color: NewMunu.selectedItems.isNotEmpty
                    ? AppColors.greenPro
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
                  ? AppColors.greenPro
                  : Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
