

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:projct/model/post_model%20.dart';

PostAdminModel productFromJson(String str) => PostAdminModel.fromJson(json.decode(str));

String productToJson(PostAdminModel data) => json.encode(data.toJson());

class PostAdminModel {
    final String title;
    final String body;
    final CreatedAt createdAt;
    final Address address;
    final List<String> types;
    final dynamic media;

    PostAdminModel({
        required this.title,
        required this.body,
        required this.createdAt,
        required this.address,
        required this.types,
        required this.media,
    });

    PostAdminModel copyWith({
        String? title,
        String? body,
        CreatedAt? createdAt,
        Address? address,
        List<String>? types,
        String? media,
    }) => 
        PostAdminModel(
            title: title ?? this.title,
            body: body ?? this.body,
            createdAt: createdAt ?? this.createdAt,
            address: address ?? this.address,
            types: types ?? this.types,
            media: media ?? this.media,
        );

    factory PostAdminModel.fromJson(Map<String, dynamic> json) => PostAdminModel(
        title: json["title"],
        body: json["body"],
        createdAt: CreatedAt.fromJson(json["created_at"]),
        address: Address.fromJson(json["address"]),
        types: List<String>.from(json["types"].map((x) => x)),
        media: json["media"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "created_at": createdAt.toJson(),
        "address": address.toJson(),
        "types": List<dynamic>.from(types.map((x) => x)),
        "media": media,
    };
}




