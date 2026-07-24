import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:projct/core/localization/app_localizations.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameraStatus = await Permission.camera.request();
    final microphoneStatus = await Permission.microphone.request();

    if (cameraStatus.isGranted && microphoneStatus.isGranted) {
      try {
        final cameras = await availableCameras();
        if (cameras.isNotEmpty) {
          _controller = CameraController(
            cameras.first,
            ResolutionPreset.high,
            enableAudio: true,
          );
          await _controller!.initialize();
          if (mounted) setState(() {});
        }
      } catch (e) {
        print("Error initializing camera: $e");
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.trNoContext(
                "report_screen.You need to allow camera",
              ),
            ),
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    try {
      final XFile picture = await _controller!.takePicture();
      final File file = File(picture.path);

      final AssetEntity? asset = await PhotoManager.editor.saveImage(
        filename: "",
        file.readAsBytesSync(),
        title: "IMG_${DateTime.now().millisecondsSinceEpoch}.jpg",
      );
      if (mounted) {
        Navigator.pop(context, asset);
      }
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  Future<void> _startRecording() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    try {
      await _controller!.startVideoRecording();
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      print("Error starting video: $e");
    }
  }

  Future<void> _stopRecording() async {
    if (_controller == null || !_controller!.value.isRecordingVideo) return;
    try {
      final XFile video = await _controller!.stopVideoRecording();
      setState(() {
        _isRecording = false;
      });

      final File file = File(video.path);
      final AssetEntity? asset = await PhotoManager.editor.saveVideo(
        file,
        title: "VID_${DateTime.now().millisecondsSinceEpoch}.mp4",
      );
      if (mounted) {
        Navigator.pop(context, asset);
      }
    } catch (e) {
      print("Error stopping video: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(child: CameraPreview(_controller!)),
          Positioned(
            bottom: 30.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _takePicture,
                  onLongPress: _startRecording,
                  onLongPressUp: _stopRecording,
                  child: Container(
                    width: 70.w,
                    height: 70.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isRecording ? Colors.red : Colors.white,
                      border: Border.all(color: Colors.grey.shade400, width: 4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40.h,
            left: 20.w,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30.sp),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          if (_isRecording)
            Positioned(
              top: 50.h,
              right: 20.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  context.tr("report_screen.details"),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
