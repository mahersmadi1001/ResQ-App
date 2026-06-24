import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveCameraTile extends StatefulWidget {
  final VoidCallback onTap;

  const LiveCameraTile({Key? key, required this.onTap}) : super(key: key);

  @override
  _LiveCameraTileState createState() => _LiveCameraTileState();
}

class _LiveCameraTileState extends State<LiveCameraTile> {
  CameraController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _controller = CameraController(
          cameras.first,
          ResolutionPreset.low,
          enableAudio: false,
        );
        await _controller!.initialize();
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (_isInitialized && _controller != null)
              ClipRect(
                child: Transform.scale(
                  scale: 1 / _controller!.value.aspectRatio,
                  child: Center(
                    child: CameraPreview(_controller!),
                  ),
                ),
              )
            else
              const Center(child: CircularProgressIndicator(color: Colors.white)),
            Center(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white.withOpacity(0.8),
                size: 32.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
