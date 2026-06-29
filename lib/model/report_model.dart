import 'dart:convert';

ReportModel reportModelFromJson(String str) =>
    ReportModel.fromJson(json.decode(str));

String reportModelToJson(ReportModel data) => json.encode(data.toJson());

class ReportModel {
  final List<String> newsType;
  final String body;
  final String latitude;
  final String longitude;
  final List<dynamic> media;

  ReportModel({
    required this.newsType,
    required this.body,
    required this.latitude,
    required this.longitude,
    required this.media,
  });

  ReportModel copyWith({
    List<String>? newsType,
    String? body,
    String? latitude,
    String? longitude,
    List<dynamic>? media,
  }) => ReportModel(
    newsType: newsType ?? this.newsType,
    body: body ?? this.body,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    media: media ?? this.media,
  );

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
    newsType: List<String>.from(json["news_type"].map((x) => x)),
    body: json["body"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    media: List<dynamic>.from(json["media"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "news_type": List<dynamic>.from(newsType.map((x) => x)),
    "body": body,
    "latitude": latitude,
    "longitude": longitude,
    "media": List<dynamic>.from(media.map((x) => x)),
  };
}
