import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/view_model/media_picker_bloc/media_picker_bloc.dart';
import 'package:projct/view_model/report_input_bloc/report_input_bloc.dart';
import 'package:projct/view_model/report_input_bloc/report_input_event.dart';
import 'package:projct/viwe/report/widgets/media_picker_sheet.dart';

class AttachmentButton extends StatelessWidget {
  const AttachmentButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final selectedMedia = await showModalBottomSheet<List<AssetEntity>>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: BlocProvider(
                create: (context) => MediaPickerBloc(),
                child: MediaPickerSheet(),
              ),
            );
          },
        );

        if (selectedMedia != null && selectedMedia.isNotEmpty) {
          if (context.mounted) {
            context.read<ReportInputBloc>().add(
              AttachmentsAdded(selectedMedia),
            );
          }
        }
      },
      icon: Icon(
        Icons.attach_file_outlined,
        color: AppColors.greenPro.withOpacity(0.7),
        size: 24.sp,
      ),
    );
  }
}
