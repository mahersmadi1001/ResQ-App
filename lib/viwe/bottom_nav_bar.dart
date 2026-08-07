import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaze_nav_bar/glaze_nav_bar.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:projct/core/localization/app_localizations.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/viwe/map_screen.dart';
import 'package:projct/viwe/post/post_screen.dart';
import 'package:projct/viwe/report/report_screen.dart';
import 'package:projct/viwe/setting/settings_screen.dart';

class ButtonNavBar extends StatefulWidget {
  const ButtonNavBar({super.key});

  @override
  State<ButtonNavBar> createState() => _ButtonNavBarState();
}

class _ButtonNavBarState extends State<ButtonNavBar> {
  final List<Widget> pages = const [
    ReportScreen(),
    PostScreen(),
    MapScreen(initLocation: LatLng(33.5138073, 36.2765279)),
    SettingsScreen(),
  ];

  int selectedpage = 0;
  final List<int> loadedPages = [0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedpage,
        children: List.generate(pages.length, (index) {
          if (loadedPages.contains(index)) {
            return pages[index];
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
      bottomNavigationBar: GlazeNavBar(
        index: selectedpage,
        key: ValueKey(Localizations.localeOf(context).languageCode),

        onTap: (value) {
          setState(() {
            selectedpage = value;
            if (!loadedPages.contains(value)) {
              loadedPages.add(value);
            }
          });
        },
        buttonBackgroundColor: AppColors.greenPro,
        buttonBorderColor: AppColors.yellowPro,
        color: AppColors.greenPro,
        height: 70.h,
        backgroundColor: AppColors.greenPro,
        items: [
          GlazeNavBarItem(
            labelStyle: TextStyle(
              color: AppColors.yellowPro,
              fontWeight: FontWeight.w600,
            ),
            child: const Icon(
              Icons.remember_me_outlined,
              color: AppColors.whitePro,
            ),
            label: context.tr('general.report'),
          ),
          GlazeNavBarItem(
            labelStyle: TextStyle(
              color: AppColors.yellowPro,
              fontWeight: FontWeight.w600,
            ),
            child: const Icon(Icons.newspaper, color: AppColors.whitePro),
            label: context.tr('general.posts'),
          ),
          GlazeNavBarItem(
            labelStyle: TextStyle(
              color: AppColors.yellowPro,
              fontWeight: FontWeight.w600,
            ),
            child: const Icon(Icons.map, color: AppColors.whitePro),
            label: context.tr('general.map'),
          ),
          GlazeNavBarItem(
            labelStyle: TextStyle(
              color: AppColors.yellowPro,
              fontWeight: FontWeight.w600,
            ),
            child: const Icon(
              Icons.settings_outlined,
              color: AppColors.whitePro,
            ),
            label: context.tr('general.settings'),
          ),
        ],
      ),
    );
  }
}
