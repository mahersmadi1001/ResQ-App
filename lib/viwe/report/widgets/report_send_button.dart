import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/view_model/report_input_bloc/report_input_bloc.dart';
import 'package:projct/view_model/report_input_bloc/report_input_event.dart';

class ReportSendButton extends StatelessWidget {
  const ReportSendButton({Key? key}) : super(key: key);

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
        onPressed: () {
          final state = context.read<ReportInputBloc>().state;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "تم الإرسال: ${state.text.isNotEmpty ? state.text : 'بدون نص'} ومع ${state.attachments.length} مرفقات"
              ),
            ),
          );
          context.read<ReportInputBloc>().add(ClearInput());
        },
        icon: Icon(Icons.send_rounded, color: ColorsApp.yalwoPro, size: 24.sp),
      ),
    );
  }
}
