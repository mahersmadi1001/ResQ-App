import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:projct/core/localization/app_localizations.dart';
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
                  return Center(
                    child: Text(
                      context.tr("posts_screen.there_is_no_information"),
                    ),
                  );
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
              return Center(
                child: Text(
                  state.errorMessage ?? context.tr("posts_screen.user_post"),
                ),
              );
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
            isDismissible: true,
            backgroundColor:
                Colors.transparent,
            context: context,
            builder: (context) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(
                        //   context.tr(
                        //     "settings_screen.profile_details",
                        //   ),
                        //   style: TextStyle(
                        //     fontSize: 18.sp,
                        //     fontWeight: FontWeight.bold,
                        //     color: ColorsApp.greenPro,
                        //   ),
                        // ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey.shade600,
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey.shade200),
                    SizedBox(height: 12.h),

                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 350.h),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: const FilterAddressPost(),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<PostBloc>().add(
                            GetAllPost(
                              filterParamtr: FilterAddressPost.optiosSelected,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsApp.yalwoPro,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Text(
                          context.tr("general.confirm_selection"),
                          style: TextStyle(
                            color: ColorsApp.greenPro,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
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
