import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/constens/constens.dart';

class ListAddress extends StatefulWidget {
  ListAddress({super.key});
  static String? selectedAddress;
  @override
  State<ListAddress> createState() => _ListAddressState();
}

class _ListAddressState extends State<ListAddress> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      spacing: 17.w,
      runSpacing: 16.h,
      children: ConstensApp.damascusDistricts.map((district) {
        return ChoiceChip(
          label: Text(district),

          selected: ListAddress.selectedAddress == district,

          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                ListAddress.selectedAddress = district;
              }
            });
            print(ListAddress.selectedAddress);
          },
          backgroundColor: ColorsApp.greenPro,
          selectedColor: ColorsApp.yalwoPro,
          labelStyle: TextStyle(
            fontSize: 16.sp,
            color: ColorsApp.withePro,
            fontWeight: ListAddress.selectedAddress == district
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        );
      }).toList(),
    );
  }
}
