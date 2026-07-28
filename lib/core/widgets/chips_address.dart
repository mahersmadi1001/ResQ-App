import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/localization/app_localizations.dart';
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

class FilterAddressPost extends StatefulWidget {
  const FilterAddressPost({super.key});

  static List<String> optiosSelected = [];

  @override
  State<FilterAddressPost> createState() => _FilterAddressPostState();
}

class _FilterAddressPostState extends State<FilterAddressPost> {
  final List<String> _apiValues = const [
    "Kafr Sousa",
    "Al-Mazza",
    "As-Salihiya",
    "Rukn ad-Din",
    "Al-Muhajerin",
    "Al-Midan",
    "Ash-Shaghour",
    "Ancient City of Damascus",
    "Sarouja",
    "Al-Qaboun",
    "Barza",
    "Dummar",
    "Al-Qanawat",
    "Al-Yarmuk",
    "Joubar",
    "Al-Qadam",
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 12.h,
      alignment: WrapAlignment.center,
      children: List.generate(ConstensApp.damascusDistrictsfilter.length, (
        index,
      ) {
        final String districtKey = ConstensApp.damascusDistrictsfilter[index];
        final String apiValue = _apiValues[index];

        final bool isSelected = FilterAddressPost.optiosSelected.contains(
          apiValue,
        );

        return FilterChip(
          label: Text(context.tr(districtKey)),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                FilterAddressPost.optiosSelected.add(apiValue);
              } else {
                FilterAddressPost.optiosSelected.remove(apiValue);
              }
            });
          },
          selectedColor: ColorsApp.greenPro,
          backgroundColor: Colors.grey.shade100,
          checkmarkColor: ColorsApp.yalwoPro,
          showCheckmark: true,
          side: BorderSide(
            color: isSelected ? ColorsApp.greenPro : Colors.grey.shade300,
            width: 1.w,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          labelStyle: TextStyle(
            fontSize: 14.sp,
            color: isSelected ? Colors.white : ColorsApp.greenPro,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        );
      }),
    );
  }
}
// SegmentedButton<String>(
//   segments: const [
//     ButtonSegment<String>(value: 'en', label: Text('English')),
//     ButtonSegment<String>(value: 'ar', label: Text('العربية')),
//   ],
//   selected: {_selectedLanguageCode}, // القيمة الحالية المخزنة في الكود
//   onSelectionChanged: (Set<String> newSelection) {
//     setState(() {
//       _selectedLanguageCode = newSelection.first; // التعامل مع القيمة مباشرة
//     });
//   },
// )