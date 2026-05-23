import 'package:hive/hive.dart';

class UserModel {
  final String officialIdentifier;
  final String officialIdentifierMethod;
  final String firstName;
  final String lastName;
  final String email;

  UserModel({
    required this.officialIdentifier,
    required this.officialIdentifierMethod,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      officialIdentifier: json['official_identifier']?.toString() ?? '',
      officialIdentifierMethod:
          json['official_identifier_method']?.toString() ?? '',
      firstName: json['first_name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'official_identifier': officialIdentifier,
      'official_identifier_method': officialIdentifierMethod,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
    };
  }
}

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    return UserModel(
      officialIdentifier: reader.readString(),
      officialIdentifierMethod: reader.readString(),
      firstName: reader.readString(),
      lastName: reader.readString(),
      email: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeString(obj.officialIdentifier);
    writer.writeString(obj.officialIdentifierMethod);
    writer.writeString(obj.firstName);
    writer.writeString(obj.lastName);
    writer.writeString(obj.email);
  }
}
