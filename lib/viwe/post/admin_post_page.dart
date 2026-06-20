import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:projct/core/widgets/form_post.dart';
import 'package:projct/model/post_admin_model.dart';
import 'package:projct/view_model/post_admin_bloc/post_admin_bloc.dart';
import 'package:projct/view_model/post_bloc/post_bloc.dart';

class AdminPostPage extends StatefulWidget {
  const AdminPostPage({super.key});

  @override
  State<AdminPostPage> createState() => _AdminPostPageState();
}

class _AdminPostPageState extends State<AdminPostPage> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 400) {
        context.read<PostAdminBloc>().add(GetAllPostAdmin());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostAdminBloc, PostAdminState>(
        builder: (context, state) {
          switch (state.postAdminStatus) {
            case PostAdminStatus.initial:
              return Center(child: CircularProgressIndicator());
            case PostAdminStatus.success:
              {
                if (state.postsAdmin.isEmpty) {
                  return Center(child: Text("No Data"));
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<PostAdminBloc>().add(GetAllPostAdmin());
                    },
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: state.hasReachedMax
                          ? state.postsAdmin.length
                          : state.postsAdmin.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.postsAdmin.length) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          PostAdminModel post = state.postsAdmin[index];
                          return FormPost(
                            address: post.address,
                            descration: post.types.toString(),
                            date: post.createdAt.date.toString(),
                            time: post.createdAt.time.toString(),
                            imagePath: post.media,
                          );
                        }
                      },
                    ),
                  );
                }
              }
            case PostAdminStatus.failure:
              return Center(child: Text(state.errorMessage ?? "Error Message"));
            case PostAdminStatus.loading:
              {
                if (state.postsAdmin.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<PostBloc>().add(GetAllPost());
                    },
                    child: ListView.builder(
                      controller: scrollController,

                      itemCount: state.hasReachedMax
                          ? state.postsAdmin.length
                          : state.postsAdmin.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.postsAdmin.length) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          PostAdminModel post = state.postsAdmin[index];
                          return FormPost(
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
