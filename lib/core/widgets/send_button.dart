import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';

class SendButton extends StatelessWidget {
  const SendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: ColorsApp.yalwoPro),
        color: ColorsApp.greenPro,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: ColorsApp.greenPro.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.send_rounded, color: ColorsApp.yalwoPro, size: 28.sp),
      ),
    );
  }
}
