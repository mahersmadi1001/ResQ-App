import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/form_post.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.tune_outlined, color: ColorsApp.withePro),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.r)),
        ),
        onPressed: () {},
        backgroundColor: ColorsApp.greenPro,
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: SizedBox(),
        surfaceTintColor: ColorsApp.greenPro,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.r),
            bottomRight: Radius.circular(15.r),
          ),
        ),
        title: Text(
          "News Page",
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
      body: ListView(
        children: [
          FormPost(
            address: "damascus/qabon/abogarash",
            descration:
                "mamdkwdkwd aldasdl kdalskds askmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmdjsad",
            date: "12/12/2026",
            time: "12:22:46",
            imagePath: "images/Screenshot_٢٠٢٦٠٤٠٤_٢٠٥٢١٨.jpg",
          ),
          FormPost(
            address: "damascus",
            descration: "asdwpw[] asska kdalskds ewps;",
            date: "10/5/2025",
            time: "1:2:8",
            imagePath: "images/IMG_٢٠٢٦٠٤٠٤_٢٠٥٠٥٣.jpg",
          ),
          FormPost(
            address: "damascus",
            descration: "mdksadkw qwodkodnwqopd qwdodwqdow",
            date: "11/15/2017",
            time: "2:4:4",
            imagePath: "images/IMG_٢٠٢٦٠٤٠٤_٢٠٥٨٥٤.jpg",
          ),
          FormPost(
            address: "damascus",
            descration: "mdksadkw qwodkodnwqopd qwdodwqdow",
            date: "11/15/2017",
            time: "1:1:4",
            imagePath: "images/Screenshot_٢٠٢٦٠٤٠٤_٢٠٥٦٣٣.jpg",
          ),
          FormPost(
            address: "damascus",
            descration: "mamdkwdkwd aldasdl kdalskds askdjsad",
            date: "12/12/2026",
            time: "12:22:4",
            imagePath: "images/Screenshot_٢٠٢٦٠٤٠٤_٢٠٥٢١٨.jpg",
          ),
          FormPost(
            address: "damascus",
            descration: "asdwpw[] asska kdalskds ewps;",
            date: "10/5/2025",
            time: "1:2:8",
            imagePath: "images/IMG_٢٠٢٦٠٤٠٤_٢٠٥٠٥٣.jpg",
          ),
          FormPost(
            address: "damascus",
            descration: "mdksadkw qwodkodnwqopd qwdodwqdow",
            date: "11/15/2017",
            time: "2:4:4",
            imagePath: "images/IMG_٢٠٢٦٠٤٠٤_٢٠٥٨٥٤.jpg",
          ),
          FormPost(
            address: "damascus",
            descration: "mdksadkw qwodkodnwqopd qwdodwqdow",
            date: "11/15/2017",
            time: "1:1:4",
            imagePath: "images/Screenshot_٢٠٢٦٠٤٠٤_٢٠٥٦٣٣.jpg",
          ),
          SizedBox(height: 49.h),
        ],
      ),
    );
  }
}
