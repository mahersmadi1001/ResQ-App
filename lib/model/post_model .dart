class PostModel {
  final CreatedAt createdAt;
  final Address address;
  final List<String> types;
  final dynamic media;
  final Location location;

  PostModel({
    required this.createdAt,
    required this.address,
    required this.types,
    required this.media,
    required this.location,
  });

  PostModel copyWith({
    CreatedAt? createdAt,
    Address? address,
    List<String>? types,
    dynamic media,
    Location? location,
  }) => PostModel(
    createdAt: createdAt ?? this.createdAt,
    address: address ?? this.address,
    types: types ?? this.types,
    media: media ?? this.media,
    location: location ?? this.location,
  );

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    createdAt: CreatedAt.fromJson(json["created_at"]),
    address: Address.fromJson(json["address"]),
    types: List<String>.from(json["types"].map((x) => x)),
    media: json["media"],
    location: Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt.toJson(),
    "address": address.toJson(),
    "types": List<dynamic>.from(types.map((x) => x)),
    "media": media,
    "location": location.toJson(),
  };
}

class Address {
  final String street;
  final String city;
  final String governorate;

  Address({
    required this.street,
    required this.city,
    required this.governorate,
  });

  Address copyWith({String? street, String? city, String? governorate}) =>
      Address(
        street: street ?? this.street,
        city: city ?? this.city,
        governorate: governorate ?? this.governorate,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json["street"],
    city: json["city"],
    governorate: json["governorate"],
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "city": city,
    "governorate": governorate,
  };
}

class CreatedAt {
  final String date;
  final String time;

  CreatedAt({required this.date, required this.time});

  CreatedAt copyWith({String? date, String? time}) =>
      CreatedAt(date: date ?? this.date, time: time ?? this.time);

  factory CreatedAt.fromJson(Map<String, dynamic> json) =>
      CreatedAt(date: json["date"], time: json["time"]);

  Map<String, dynamic> toJson() => {"date": date, "time": time};
}

class Location {
  final double longitude;
  final double latitude;

  Location({required this.longitude, required this.latitude});

  Location copyWith({double? longitude, double? latitude}) => Location(
    longitude: longitude ?? this.longitude,
    latitude: latitude ?? this.latitude,
  );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "longitude": longitude,
    "latitude": latitude,
  };
}
