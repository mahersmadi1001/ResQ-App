import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/chips_address.dart';

class UsersPostPage extends StatefulWidget {
  const UsersPostPage({super.key});

  @override
  State<UsersPostPage> createState() => _UsersPostPageState();
}

class _UsersPostPageState extends State<UsersPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.r)),
        ),
        onPressed: () {
          showModalBottomSheet(
            isDismissible: true,
            backgroundColor: ColorsApp.withePro,
            context: context,
            builder: (context) {
              return SizedBox(
                height: 375.h,
                child: Center(child: ListAddress()),
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
