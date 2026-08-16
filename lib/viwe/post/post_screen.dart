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
          appBar: AppBar(
            animateColor: true,
            bottom: TabBar(
              overlayColor: WidgetStateColor.transparent,
              indicatorColor: AppColors.yellowPro,
              // dividerColor: AppColors.yellowPro,
              indicatorPadding: EdgeInsets.all(8.sp),
              unselectedLabelColor: AppColors.whitePro,
              labelStyle: TextStyle(color: AppColors.yellowPro),
              tabs: [
                Tab(
                  text: context.tr("posts_screen.user_post"),
                  icon: Icon(Icons.web, color: AppColors.whitePro),
                ),
                Tab(
                  text: context.tr("posts_screen.admin_post"),
                  icon: Icon(
                    Icons.admin_panel_settings,
                    color: AppColors.whitePro,
                  ),
                ),
              ],
            ),
            leading: const SizedBox(),
            surfaceTintColor: AppColors.greenPro,
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
                color: AppColors.yellowPro,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColors.greenPro,
          ),
          body: TabBarView(children: [UsersPostPage(), AdminPostPage()]),
        ),
      ),
    );
  }
}
