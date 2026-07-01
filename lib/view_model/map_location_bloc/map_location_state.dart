import 'package:equatable/equatable.dart';
import 'package:projct/model/location_point_model.dart';

abstract class MapLocationState extends Equatable {}

class MapLocationInitial extends MapLocationState {
  @override
  List<Object?> get props => [];
}

class MapLocationLoading extends MapLocationState {
  @override
  List<Object?> get props => [];
}

class MapLocationLoaded extends MapLocationState {
  final List<LocationPointModel> locations;

  MapLocationLoaded({required this.locations});

  @override
  List<Object?> get props => [locations];
}

class MapLocationError extends MapLocationState {
  final String message;

  MapLocationError({required this.message});

  @override
  List<Object?> get props => [message];
}
