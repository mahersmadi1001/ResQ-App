import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/viwe/news_screen.dart';
import 'package:projct/viwe/profile_screen.dart';
import 'package:projct/viwe/rebort_screen.dart';

class ButtonNavBar extends StatefulWidget {
  const ButtonNavBar({super.key});

  @override
  State<ButtonNavBar> createState() => _ButtonNavBarState();
}

class _ButtonNavBarState extends State<ButtonNavBar> {
  List<Widget> pages = [RebortScreen(), NewsScreen(), ProfileScreen()];

  int selectedpage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedpage],
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
            });
          },
          backgroundColor: ColorsApp.greenPro,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.remember_me_outlined, color: ColorsApp.withePro),
              selectedIcon: Icon(
                Icons.remember_me_outlined,
                color: ColorsApp.yalwoPro,
              ),
              label: "Rebort",
            ),
            NavigationDestination(
              enabled: true,
              icon: Icon(Icons.newspaper, color: ColorsApp.withePro),
              label: "News",
              selectedIcon: Icon(Icons.newspaper, color: ColorsApp.yalwoPro),
            ),
            NavigationDestination(
              enabled: true,
              icon: Icon(Icons.map, color: ColorsApp.withePro),
              label: "Map",
              selectedIcon: Icon(Icons.map, color: ColorsApp.yalwoPro),
            ),
          ],
        ),
      ),
    );
  }
}
