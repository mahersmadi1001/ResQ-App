class LocationPointModel {
  final double latitude;
  final double longitude;

  LocationPointModel({
    required this.latitude,
    required this.longitude,
  });

  factory LocationPointModel.fromJson(Map<String, dynamic> json) {
    return LocationPointModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}