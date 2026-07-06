import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/core/widgets/new_munu.dart';
import 'package:projct/view_model/report_input_bloc/report_input_bloc.dart';
import 'package:projct/view_model/report_input_bloc/report_input_event.dart';
import 'package:projct/view_model/report_input_bloc/report_input_state.dart';
import 'package:projct/viwe/report/widgets/voice_recording_button.dart';
import 'package:projct/viwe/report/widgets/attachment_button.dart';
import 'package:projct/viwe/report/widgets/report_send_button.dart';
import 'package:projct/viwe/report/widgets/recording_layout.dart';
import 'package:projct/viwe/report/widgets/selected_attachments_list.dart';

class ReportInputArea extends StatefulWidget {
  const ReportInputArea({Key? key}) : super(key: key);

  @override
  State<ReportInputArea> createState() => _ReportInputAreaState();
}

class _ReportInputAreaState extends State<ReportInputArea> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReportInputBloc, ReportInputState>(
      listener: (context, state) {
        if (state.text != _textController.text) {
          _textController.text = state.text;
        }
      },
      builder: (context, state) {
        if (state.status == ReportInputStatus.recording) {
          return RecordingLayout(duration: state.recordingDuration);
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectedAttachmentsList(attachments: state.attachments),
            if (state.recordedAudioDuration != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsApp.greenPro.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: ColorsApp.greenPro),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.mic, color: ColorsApp.greenPro, size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          "تسجيل صوتي (${state.recordedAudioDuration} ثانية)",
                          style: TextStyle(
                            color: ColorsApp.greenPro,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: () {
                            context.read<ReportInputBloc>().add(RemoveAudio());
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (state.status == ReportInputStatus.idle)
                    const VoiceRecordingButton(),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width:
                        (state.status == ReportInputStatus.idle &&
                            NewMunu.selectedItems.isNotEmpty)
                        ? 250.w
                        : ((state.status == ReportInputStatus.idle ||
                                  NewMunu.selectedItems.isNotEmpty)
                              ? 260.w
                              : 310.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25.r)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: TextFormField(
                      controller: _textController,
                      onChanged: (text) {
                        context.read<ReportInputBloc>().add(TextChanged(text));
                      },
                      keyboardType: TextInputType.multiline,
                      cursorColor: ColorsApp.greenPro,
                      maxLines: 3,
                      minLines: 1,
                      style: TextStyle(color: Colors.black87, fontSize: 16.sp),
                      decoration: InputDecoration(
                        hintText: "Write Here ...",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 16.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        prefixIcon:
                            state.recordedAudioDuration != null ||
                                state.attachments.isNotEmpty
                            ? null
                            : const AttachmentButton(),
                      ),
                    ),
                  ),

                  if (NewMunu.selectedItems.isNotEmpty)
                    Expanded(child: const ReportSendButton())
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
