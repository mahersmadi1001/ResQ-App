import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projct/core/erorr/erorr_handling.dart';

import 'package:projct/service/map_location_service.dart';
import 'package:projct/view_model/map_location_bloc/map_location_event.dart';
import 'package:projct/view_model/map_location_bloc/map_location_state.dart';

class MapLocationBloc extends Bloc<MapLocationEvent, MapLocationState> {
  final MapLocationService service;

  MapLocationBloc({required this.service}) : super(MapLocationInitial()) {
    on<FetchLocationsEvent>((event, emit) async {
      emit(MapLocationLoading());
      try {
        final locations = await service.fetchLocations();
        emit(MapLocationLoaded(locations: locations));
      } on Failure catch (e) {
        emit(MapLocationError(message: e.message.toString()));
      }
    });
  }
}
