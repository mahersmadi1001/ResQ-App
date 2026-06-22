import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/model/item_munu_modal.dart';

class AttachmentPickerButton extends StatefulWidget {
  final List<AttachmentItem> items;

  final Function(List<AttachmentItem>) onSelected;
  final String hint;

  const AttachmentPickerButton({
    super.key,
    required this.items,
    required this.onSelected,
    this.hint = "Select States",
  });

  @override
  State<AttachmentPickerButton> createState() => _AttachmentPickerButtonState();
}

class _AttachmentPickerButtonState extends State<AttachmentPickerButton> {
  final List<AttachmentItem> _selectedItems = [];

  void _showMenu() {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,

      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(),
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    alignment: WrapAlignment.center,
                    children: widget.items.map((item) {
                      final bool isSelected = _selectedItems.contains(item);

                      return GestureDetector(
                        onTap: () {
                          setModalState(() {
                            if (isSelected) {
                              _selectedItems.remove(item);
                            } else {
                              _selectedItems.add(item);
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
                                  backgroundColor: ColorsApp.greenPro.withAlpha(
                                    240,
                                  ),
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
                      widget.onSelected(_selectedItems);
                    },
                    color: ColorsApp.greenPro,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                      side: BorderSide(color: ColorsApp.yalwoPro, width: 2.w),
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 10,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: ColorsApp.yalwoPro, width: 3.w),
        borderRadius: BorderRadius.all(Radius.circular(22.r)),
      ),
      color: ColorsApp.greenPro,
      onPressed: _showMenu,
      height: 50.h,
      child: SizedBox(
        width: 240.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              _selectedItems.isNotEmpty ? "تم الاختيار" : widget.hint,
              style: TextStyle(color: ColorsApp.yalwoPro, fontSize: 18.sp),
            ),
            Icon(Icons.token_rounded, color: ColorsApp.yalwoPro, size: 28.sp),
          ],
        ),
      ),
    );
  }
}


