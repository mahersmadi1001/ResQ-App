import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import 'package:projct/core/theme/colors_app.dart';

import 'package:projct/viwe/map_screen.dart';
import 'package:projct/viwe/post/post_screen.dart';
import 'package:projct/viwe/report/report_screen.dart';
import 'package:projct/viwe/settings_screen.dart';

class ButtonNavBar extends StatefulWidget {
  const ButtonNavBar({super.key});

  @override
  State<ButtonNavBar> createState() => _ButtonNavBarState();
}

class _ButtonNavBarState extends State<ButtonNavBar> {
  List<Widget> pages = [
    ReportScreen(),
    NewsScreen(),
    MapScreen(initLocation: LatLng(33.5138073, 36.2765279)),
    SettingsScreen(),
  ];

  int selectedpage = 0;
  List<int> loadedPages = [0];

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
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
        child: NavigationBar(
          height: 70.h,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: ColorsApp.yalwoPro,
              );
            }
            return TextStyle(color: ColorsApp.withePro, fontSize: 14.sp);
          }),
          selectedIndex: selectedpage,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (value) {
            setState(() {
              selectedpage = value;
              if (!loadedPages.contains(value)) {
                loadedPages.add(value);
              }
            });
          },
          backgroundColor: ColorsApp.greenPro,
          destinations: [
            const NavigationDestination(
              icon: Icon(
                Icons.remember_me_outlined,
                color: ColorsApp.withePro,
              ),
              selectedIcon: Icon(
                Icons.remember_me_outlined,
                color: ColorsApp.yalwoPro,
              ),
              label: "Rebort",
            ),
            const NavigationDestination(
              enabled: true,
              icon: Icon(Icons.newspaper, color: ColorsApp.withePro),
              label: "Posts",
              selectedIcon: Icon(Icons.newspaper, color: ColorsApp.yalwoPro),
            ),
            const NavigationDestination(
              enabled: true,
              icon: Icon(Icons.map, color: ColorsApp.withePro),
              label: "Map",
              selectedIcon: Icon(Icons.map, color: ColorsApp.yalwoPro),
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined, color: ColorsApp.withePro),
              selectedIcon: Icon(Icons.settings, color: ColorsApp.yalwoPro),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
