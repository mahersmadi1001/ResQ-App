import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'dart:convert';

class MapScreen extends StatefulWidget {
  MapScreen({super.key, required this.initLocation});

  final LatLng initLocation;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapLibreMapController? mapController;

  static final String googleHybridStyle = jsonEncode({
    "version": 8,
    "sources": {
      "google-satellite": {
        "type": "raster",
        "tiles": ["https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}"],
        "tileSize": 256,
      },
    },
    "layers": [
      {
        "id": "google-satellite-layer",
        "type": "raster",
        "source": "google-satellite",
        "minzoom": 0,
        "maxzoom": 22,
      },
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.r),
            bottomRight: Radius.circular(15.r),
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorsApp.greenPro,
        title: Text(
          "Map Page",
          style: TextStyle(
            shadows: const [
              Shadow(
                color: Colors.black87,
                blurRadius: 7,
                offset: Offset(2, 4),
              ),
            ],
            fontSize: 23.sp,
            color: ColorsApp.yalwoPro,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              child: MapLibreMap(
                initialCameraPosition: CameraPosition(
                  target: widget.initLocation,
                  zoom: 15.0,
                  tilt: 45.0,
                ),
                styleString: googleHybridStyle,

                trackCameraPosition: false,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.tracking,
                onMapCreated: (controller) {
                  mapController = controller;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
