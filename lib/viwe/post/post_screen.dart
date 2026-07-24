import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/config/di.dart';
import 'package:projct/core/localization/app_localizations.dart';

import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/service/post_service.dart';
import 'package:projct/view_model/post_admin_bloc/post_admin_bloc.dart';
import 'package:projct/viwe/post/admin_post_page.dart';

import 'package:projct/viwe/post/users_post_page.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostAdminBloc(productService: di<PostService>())
            ..add(GetAllPostAdmin()),
      child: DefaultTabController(
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
                  text: context.tr("posts_screen.user_post"),
                  icon: Icon(Icons.web, color: ColorsApp.withePro),
                ),
                Tab(
                  text: context.tr("posts_screen.admin_post"),
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
              context.tr("posts_screen.posts_page"),
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
          body: TabBarView(children: [UsersPostPage(), AdminPostPage()]),
        ),
      ),
    );
  }
}
