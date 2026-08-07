import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projct/core/localization/app_localizations.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/circular_progress.dart';

import 'package:projct/core/widgets/form_post.dart';
import 'package:projct/model/post_admin_model.dart';
import 'package:projct/view_model/post_admin_bloc/post_admin_bloc.dart';
import 'package:projct/viwe/post/post_ditales.dart';

class AdminPostPage extends StatefulWidget {
  const AdminPostPage({super.key});

  @override
  State<AdminPostPage> createState() => _AdminPostPageState();
}

class _AdminPostPageState extends State<AdminPostPage> {
  ScrollController scrollController = ScrollController();
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostAdminBloc>().add(GetAllPostAdmin());
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 400) {
        context.read<PostAdminBloc>().add(GetAllPostAdmin());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PostAdminBloc, PostAdminState>(
        listener: (context, state) {
          if (state.postAdminStatus == PostAdminStatus.success ||
              state.postAdminStatus == PostAdminStatus.failure) {
            _refreshCompleter?.complete();
            _refreshCompleter = null;
          }
        },
        builder: (context, state) {
          switch (state.postAdminStatus) {
            case PostAdminStatus.initial:
              return Center(child: CircularPro());
            case PostAdminStatus.success:
              {
                if (state.postsAdmin.isEmpty) {
                  return Center(
                    child: Text(
                      context.tr("posts_screen.there_is_no_information"),
                    ),
                  );
                } else {
                  return RefreshIndicator(
                    color: AppColors.yellowPro,
                    onRefresh: () async {
                      _refreshCompleter = Completer<void>();
                      context.read<PostAdminBloc>().add(
                        GetAllPostAdmin(isRefresh: true),
                      );
                      await _refreshCompleter!.future;
                    },
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: state.hasReachedMax
                          ? state.postsAdmin.length
                          : state.postsAdmin.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.postsAdmin.length) {
                          return Center(child: CircularPro());
                        } else {
                          PostAdminModel post = state.postsAdmin[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PostDetailsScreen(post: post),
                                ),
                              );
                            },
                            child: FormPostAdmin(
                              address: post.address,
                              descration: post.types.toString(),
                              date: post.createdAt.date.toString(),
                              time: post.createdAt.time.toString(),
                              imagePath: post.media,
                              index: index,
                            ),
                          );
                        }
                      },
                    ),
                  );
                }
              }
            case PostAdminStatus.failure:
              return Center(
                child: Text(
                  state.errorMessage ??
                      context.tr("general.there_is_something_wrong"),
                ),
              );
            case PostAdminStatus.loading:
              {
                if (state.postsAdmin.isEmpty) {
                  return Center(child: CircularPro());
                } else {
                  return RefreshIndicator(
                    color: AppColors.yellowPro,
                    onRefresh: () async {
                      _refreshCompleter = Completer<void>();
                      context.read<PostAdminBloc>().add(
                        GetAllPostAdmin(isRefresh: true),
                      );
                      await _refreshCompleter!.future;
                    },
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: state.hasReachedMax
                          ? state.postsAdmin.length
                          : state.postsAdmin.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.postsAdmin.length) {
                          return Center(child: CircularPro());
                        } else {
                          PostAdminModel post = state.postsAdmin[index];
                          return FormPostAdmin(
                            index: index,
                            address: post.address,
                            descration: post.types.toString(),
                            date: post.createdAt.date,
                            time: post.createdAt.time,
                            imagePath: post.media,
                          );
                        }
                      },
                    ),
                  );
                }
              }
          }
        },
      ),
    );
  }
}
