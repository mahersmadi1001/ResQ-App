import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/view_model/report_input_bloc/report_input_bloc.dart';
import 'package:projct/view_model/report_input_bloc/report_input_event.dart';

class RecordingLayout extends StatefulWidget {
  final int duration;

  const RecordingLayout({Key? key, required this.duration}) : super(key: key);

  @override
  _RecordingLayoutState createState() => _RecordingLayoutState();
}

class _RecordingLayoutState extends State<RecordingLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulsingController;

  @override
  void initState() {
    super.initState();
    _pulsingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulsingController.dispose();
    super.dispose();
  }

  String _formatDuration(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    final String minutesStr = minutes.toString().padLeft(2, '0');
    final String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return "$minutesStr:$secondsStr";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      margin: EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              FadeTransition(
                opacity: _pulsingController,
                child: Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                _formatDuration(widget.duration),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Dismissible(
                key: const Key('slide_to_cancel'),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  context.read<ReportInputBloc>().add(CancelRecording());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.chevron_left,
                      color: Colors.grey.shade500,
                      size: 20.sp,
                    ),
                    Text(
                      "اسحب للإلغاء ",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              context.read<ReportInputBloc>().add(StopRecording());
            },
            child: Container(
              padding: EdgeInsets.all(8.sp),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.stop,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
