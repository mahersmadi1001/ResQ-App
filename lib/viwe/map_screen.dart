import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projct/core/localization/app_localizations.dart';
import 'package:projct/core/theme/colors_app.dart';
import 'package:projct/model/location_point_model.dart';
import 'package:projct/view_model/map_location_bloc/map_location_bloc.dart';
import 'package:projct/view_model/map_location_bloc/map_location_event.dart';
import 'package:projct/view_model/map_location_bloc/map_location_state.dart';
import 'dart:convert';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.initLocation});

  final LatLng initLocation;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapLibreMapController? _mapController;
  bool _isStyleLoaded = false;
  List<LocationPointModel> _pendingLocations = [];

  @override
  void initState() {
    super.initState();

    context.read<MapLocationBloc>().add(FetchLocationsEvent());
  }

  void _drawMarkers(List<LocationPointModel> locations) {
    if (_mapController == null || !_isStyleLoaded) return;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await _mapController!.clearCircles();
        for (var loc in locations) {
          await _mapController!.addCircle(
            CircleOptions(
              geometry: LatLng(loc.latitude, loc.longitude),
              circleColor: "#FF0000",
              circleRadius: 8.0,
              circleStrokeWidth: 2.0,
              circleStrokeColor: "#FFFFFF",
            ),
          );
        }
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapLocationBloc, MapLocationState>(
      listener: (context, state) {
        if (state is MapLocationLoaded) {
          if (_isStyleLoaded) {
            _drawMarkers(state.locations);
          } else {
            _pendingLocations = state.locations;
          }
        } else if (state is MapLocationError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.r),
              bottomRight: Radius.circular(15.r),
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.greenPro,
          title: Text(
            context.tr("map_screen.map_page"),
            style: TextStyle(
              shadows: const [
                Shadow(
                  color: Colors.black87,
                  blurRadius: 7,
                  offset: Offset(2, 4),
                ),
              ],
              fontSize: 23.sp,
              color: AppColors.yellowPro,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: StaticMapWidget(
          initLocation: widget.initLocation,
          onMapCreated: (controller) {
            _mapController = controller;
          },
          onStyleLoaded: () {
            _isStyleLoaded = true;
            if (_pendingLocations.isNotEmpty) {
              _drawMarkers(_pendingLocations);
              _pendingLocations = [];
            } else {
              final currentState = context.read<MapLocationBloc>().state;
              if (currentState is MapLocationLoaded) {
                _drawMarkers(currentState.locations);
              }
            }
          },
        ),
      ),
    );
  }
}

class StaticMapWidget extends StatelessWidget {
  final LatLng initLocation;
  final ValueChanged<MapLibreMapController> onMapCreated;
  final VoidCallback onStyleLoaded;

  const StaticMapWidget({
    super.key,
    required this.initLocation,
    required this.onMapCreated,
    required this.onStyleLoaded,
  });

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
        "maxzoom": 23,
      },
    ],
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: MapLibreMap(
        initialCameraPosition: CameraPosition(
          target: initLocation,
          zoom: 15.0,
          tilt: 45.0,
        ),
        styleString: googleHybridStyle,
        trackCameraPosition: true,
        myLocationEnabled: true,

        onMapCreated: onMapCreated,
        onStyleLoadedCallback: onStyleLoaded,
      ),
    );
  }
}
