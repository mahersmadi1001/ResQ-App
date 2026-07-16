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
  }) {
    return ReportModel(
      newsType: newsType ?? this.newsType,
      body: body ?? this.body,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      media: media ?? this.media,
    );
  }

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    final location = json['location'] as Map<String, dynamic>?;

    List<String> types = [];
    if (json['news_type[]'] != null) {
      if (json['news_type[]'] is List) {
        types = List<String>.from(json['news_type[]'].map((x) => x.toString()));
      } else {
        types = [json['news_type[]'].toString()];
      }
    } else if (json['types'] != null) {
      if (json['types'] is List) {
        types = List<String>.from(json['types'].map((x) => x.toString()));
      }
    }

    List<dynamic> mediaList = [];
    if (json['media'] != null) {
      if (json['media'] is List) {
        mediaList = List<dynamic>.from(json['media']);
      } else {
        mediaList = [json['media']];
      }
    }

    return ReportModel(
      newsType: types,
      body: json['body']?.toString() ?? '',
      latitude:
          location?['latitude']?.toString() ??
          json['latitude']?.toString() ??
          '',
      longitude:
          location?['longitude']?.toString() ??
          json['longitude']?.toString() ??
          '',
      media: mediaList,
    );
  }

  Map<String, dynamic> toJson() => {
    "news_type[]": newsType,
    "body": body,
    "latitude": latitude,
    "longitude": longitude,
    "media": media,
  };
}
