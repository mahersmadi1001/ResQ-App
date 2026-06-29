import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/view_model/report_input_bloc/report_input_bloc.dart';
import 'package:projct/view_model/report_input_bloc/report_input_event.dart';

class VoiceRecordingButton extends StatelessWidget {
  const VoiceRecordingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {
          context.read<ReportInputBloc>().add(StartRecording());
        },
        icon: Icon(
          Icons.mic,
          color: Colors.grey.shade700,
          size: 28.sp,
        ),
      ),
    );
  }
}
