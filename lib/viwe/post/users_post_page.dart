import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/chips_address.dart';
import 'package:projct/core/widgets/form_post.dart';
import 'package:projct/model/post_model%20.dart';
import 'package:projct/view_model/post_bloc/post_bloc.dart';
import 'package:projct/viwe/map_screen.dart';

class UsersPostPage extends StatefulWidget {
  const UsersPostPage({super.key});

  @override
  State<UsersPostPage> createState() => _UsersPostPageState();
}

class _UsersPostPageState extends State<UsersPostPage> {
  ScrollController scrollController = ScrollController();
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostBloc>().add(GetAllPost());
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        context.read<PostBloc>().add(GetAllPost());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state.postStatus == PostStatus.success ||
              state.postStatus == PostStatus.failure) {
            _refreshCompleter?.complete();
            _refreshCompleter = null;
          }
        },
        builder: (context, state) {
          switch (state.postStatus) {
            case PostStatus.initial:
              return Center(child: CircularProgressIndicator());
            case PostStatus.success:
              {
                if (state.posts.isEmpty) {
                  return Center(child: Text("No Data"));
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      _refreshCompleter = Completer<void>();
                      context.read<PostBloc>().add(
                        GetAllPost(
                          filterParamtr: FilterAddressPost.optiosSelected,
                          isRefresh: true,
                        ),
                      );
                      await _refreshCompleter!.future;
                    },
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: state.hasReachedMax
                          ? state.posts.length
                          : state.posts.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.posts.length) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          PostModel post = state.posts[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapScreen(
                                    initLocation: LatLng(
                                      post.location.latitude,
                                      post.location.longitude,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: FormPost(
                              address: post.address,
                              descration: post.types.toString(),
                              date: post.createdAt.date.toString(),
                              time: post.createdAt.time.toString(),
                              imagePath: post.media,
                            ),
                          );
                        }
                      },
                    ),
                  );
                }
              }
            case PostStatus.failure:
              return Center(child: Text(state.errorMessage ?? "Error Message"));
            case PostStatus.loading:
              {
                if (state.posts.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      _refreshCompleter = Completer<void>();
                      context.read<PostBloc>().add(
                        GetAllPost(
                          filterParamtr: FilterAddressPost.optiosSelected,
                          isRefresh: true,
                        ),
                      );
                      await _refreshCompleter!.future;
                    },
                    child: ListView.builder(
                      controller: scrollController,

                      itemCount: state.hasReachedMax
                          ? state.posts.length
                          : state.posts.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.posts.length) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          PostModel post = state.posts[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapScreen(
                                    initLocation: LatLng(
                                      post.location.latitude,
                                      post.location.longitude,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: FormPost(
                              address: post.address,
                              descration: post.types.toString(),
                              date: post.createdAt.date,
                              time: post.createdAt.time,
                              imagePath: post.media,
                            ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.r)),
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            backgroundColor: Colors.white,
            context: context,
            builder: (context) {
              return SizedBox(
                height: 450.h,
                child: ListView(
                  children: [
                    Center(child: FilterAddressPost()),
                    SizedBox(height: 15.h),
                    MaterialButton(
                      onPressed: () {
                        context.read<PostBloc>().add(
                          GetAllPost(
                            filterParamtr: FilterAddressPost.optiosSelected,
                          ),
                        );

                        Navigator.pop(context);
                      },
                      color: ColorsApp.yalwoPro,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                        side: BorderSide(color: ColorsApp.yalwoPro, width: 2.w),
                      ),
                      minWidth: 200.w,
                      height: 50.h,
                      child: Text(
                        "تأكيد الاختيار",
                        style: TextStyle(
                          color: ColorsApp.greenPro,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: ColorsApp.greenPro,
        child: const Icon(Icons.tune_outlined, color: ColorsApp.withePro),
      ),
    );
  }
}
