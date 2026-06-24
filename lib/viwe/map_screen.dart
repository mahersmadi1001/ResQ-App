import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:projct/core/theme/colors_app.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapLibreMapController? mapController;
  final String mapStyleUrl = "https://tiles.openfreemap.org/styles/bright";

  void _changeMapLanguage(String langCode) async {
    if (mapController == null) return;

    String textFieldValue = "['get', 'name:$langCode']";
    if (langCode == 'local') textFieldValue = "['get', 'name']";

    final layers = [
      'settlement-label',
      'road-label',
      'poi-label',
      'state-label',
    ];

    for (String layer in layers) {
      try {
        await mapController!.setLayerProperties(
          layer,
          SymbolLayerProperties(textField: textFieldValue),
        );
      } catch (e) {
        print(e);
      }
    }
  }

  void _enable3DBuildings() async {
    if (mapController == null) return;

    try {
      await mapController!.addLayer(
        "building-3d",
        "openmaptiles",
        FillExtrusionLayerProperties(
          fillExtrusionColor: "#aaaaaa",
          fillExtrusionHeight: ["get", "height"],
          fillExtrusionBase: ["get", "min_height"],
          fillExtrusionOpacity: 0.8,
        ),
      );
    } catch (e) {
      print(e);
    }
  }

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
          MapLibreMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(46.83033, 31.21736),
              zoom: 15.0,
              tilt: 45.0,
            ),
            styleString: mapStyleUrl,

            onMapCreated: (controller) {
              mapController = controller;
            },
            onStyleLoadedCallback: () {
              _enable3DBuildings();
              _changeMapLanguage('ar');
            },
          ),
        ],
      ),
    );
  }
}
