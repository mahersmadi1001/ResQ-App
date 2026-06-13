import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/form_post.dart';
import 'package:projct/viwe/post/users_post_page.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          animateColor: true,
          bottom: TabBar(
            overlayColor: WidgetStateColor.transparent,
            indicatorColor: ColorsApp.yalwoPro,
            dividerColor: ColorsApp.yalwoPro,
            indicatorPadding: EdgeInsets.all(8.sp),
            unselectedLabelColor: ColorsApp.withePro,
            labelStyle: TextStyle(color: ColorsApp.yalwoPro),
            tabs: [
              Tab(
                text: "User Post",
                icon: Icon(Icons.web, color: ColorsApp.withePro),
              ),
              Tab(
                text: "Admin Post",
                icon: Icon(
                  Icons.admin_panel_settings,
                  color: ColorsApp.withePro,
                ),
              ),
            ],
          ),
          leading: const SizedBox(),
          surfaceTintColor: ColorsApp.greenPro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          title: Text(
            "Posts Page",
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
          centerTitle: true,
          backgroundColor: ColorsApp.greenPro,
        ),
        body: TabBarView(children: [UsersPostPage(), Scaffold()]),
      ),
    );
  }
}
