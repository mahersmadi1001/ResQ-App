import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:projct/core/localization/app_localizations.dart';
import 'package:projct/viwe/report/widgets/camera_screen.dart';

class LiveCameraTile extends StatelessWidget {
  final Function(AssetEntity) onMediaCaptured;

  const LiveCameraTile({Key? key, required this.onMediaCaptured})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final AssetEntity? newAsset = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CameraScreen()),
        );

        if (newAsset != null) {
          onMediaCaptured(newAsset);
        }
      },
      child: Container(
        color: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              color: Colors.white.withOpacity(0.9),
              size: 36.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              context.tr("Posts_screen.camera"),
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
