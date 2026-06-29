import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/form_post.dart';
import 'package:projct/model/post_admin_model.dart';
import 'package:projct/model/post_model%20.dart';
import 'package:projct/viwe/bottom_nav_bar.dart';

class PostDetailsScreen extends StatelessWidget {
  final PostAdminModel post;
  final int? index;
  PostDetailsScreen({super.key, required this.post, this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          PostDetailsAppBar(post: post, index: index),
          SliverToBoxAdapter(child: PostDetailsContent(post: post)),
        ],
      ),
    );
  }
}

class PostDetailsAppBar extends StatelessWidget {
  final PostAdminModel post;
  final int? index;
  const PostDetailsAppBar({super.key, required this.post, required this.index});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320.h,
      pinned: true,
      backgroundColor: ColorsApp.greenPro,
      elevation: 0,
      leading: const AppBarBackButton(),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: post.media != null
                  ? Image.network(post.media, fit: BoxFit.cover)
                  : ErorrImage(),
            ),
            const PostImageGradientOverlay(),
          ],
        ),
      ),
    );
  }
}

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black26,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          iconSize: 18.sp,
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}

class PostImageGradientOverlay extends StatelessWidget {
  const PostImageGradientOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black45,
              Colors.transparent,
              Colors.transparent,
              Colors.grey.shade50,
            ],
            stops: const [0.0, 0.2, 0.8, 1.0],
          ),
        ),
      ),
    );
  }
}

class PostDetailsContent extends StatelessWidget {
  final PostAdminModel post;

  const PostDetailsContent({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          PostTypeTagsList(types: post.types),
          SizedBox(height: 16.h),
          PostTitleText(title: post.title),
          SizedBox(height: 12.h),
          PostMetaDateTime(createdAt: post.createdAt),
          SizedBox(height: 24.h),
          PostLocationCard(address: post.address),
          SizedBox(height: 24.h),
          PostSectionHeading(title: "Details"),
          SizedBox(height: 10.h),
          PostBodyText(body: post.body),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

class PostTypeTagsList extends StatelessWidget {
  final List<String> types;

  const PostTypeTagsList({super.key, required this.types});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: List.generate(
        types.length,
        (index) => PostTagBadge(text: types[index]),
      ),
    );
  }
}

class PostTagBadge extends StatelessWidget {
  final String text;

  const PostTagBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: ColorsApp.yalwoPro.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorsApp.yalwoPro.withOpacity(0.3),
          width: 1.w,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: ColorsApp.greenPro,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class PostTitleText extends StatelessWidget {
  final String title;

  const PostTitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: ColorsApp.greenPro,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        height: 1.3,
      ),
    );
  }
}

class PostMetaDateTime extends StatelessWidget {
  final CreatedAt createdAt;

  const PostMetaDateTime({super.key, required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.access_time_rounded, size: 16.sp, color: ColorsApp.yalwoPro),
        SizedBox(width: 6.w),
        Text(
          "${createdAt.date}  •  ${createdAt.time}",
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class PostLocationCard extends StatelessWidget {
  final Address address;

  const PostLocationCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100, width: 1.w),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: ColorsApp.greenPro.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_on_rounded,
              color: ColorsApp.greenPro,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.city,
                  style: TextStyle(
                    color: ColorsApp.greenPro,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  address.street,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PostSectionHeading extends StatelessWidget {
  final String title;

  const PostSectionHeading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: ColorsApp.greenPro,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }
}

class PostBodyText extends StatelessWidget {
  final String body;

  const PostBodyText({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100, width: 1.w),
      ),
      child: Text(
        body,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 15.sp,
          height: 1.6,
        ),
      ),
    );
  }
}
