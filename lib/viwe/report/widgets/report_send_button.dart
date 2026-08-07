import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/circular_progress.dart';
import 'package:projct/core/widgets/new_munu.dart';
import 'package:projct/view_model/report_input_bloc/report_input_bloc.dart';
import 'package:projct/view_model/send_report_bloc/send_report_bloc.dart';
import 'package:projct/view_model/send_report_bloc/send_report_event.dart';
import 'package:projct/view_model/send_report_bloc/send_report_state.dart';

class ReportSendButton extends StatelessWidget {
  const ReportSendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendReportBloc, SendReportState>(
      builder: (context, sendState) {
        final isLoading = sendState is SendReportLoading;
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 3, color: AppColors.yellowPro),
            color: AppColors.greenPro,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.greenPro.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            onPressed: isLoading
                ? null
                : () {
                    final inputState = context.read<ReportInputBloc>().state;
                    context.read<SendReportBloc>().add(
                      SubmitReportEvent(
                        text: inputState.text,
                        incidentTypes: NewMunu.selectedItems,
                        attachments: inputState.attachments,
                        recordedAudioPath: inputState.recordedAudioPath,
                      ),
                    );
                  },
            icon: isLoading
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularPro(
                
                    ),
                  )
                : Icon(
                    Icons.send_rounded,
                    color: AppColors.yellowPro,
                    size: 24.sp,
                  ),
          ),
        );
      },
    );
  }
}
