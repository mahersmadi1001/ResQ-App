// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignUpModel {
  String firstName;
  String lastName;
  String email;
  String address;
  String idOrPassport;
  String password;
  String type;
  SignUpModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.idOrPassport,
    required this.password,
    required this.type,
  });

  SignUpModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? address,
    String? idOrPassport,
    String? password,
    String? type,
  }) {
    return SignUpModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      address: address ?? this.address,
      idOrPassport: idOrPassport ?? this.idOrPassport,
      password: password ?? this.password,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'address': address,
      'idOrPassport': idOrPassport,
      'password': password,
      'type': type,
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      idOrPassport: map['idOrPassport'] as String,
      password: map['password'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpModel.fromJson(String source) =>
      SignUpModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignUpModel(firstName: $firstName, lastName: $lastName, email: $email, address: $address, idOrPassport: $idOrPassport, password: $password, type: $type)';
  }

  @override
  bool operator ==(covariant SignUpModel other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.address == address &&
        other.idOrPassport == idOrPassport &&
        other.password == password &&
        other.type == type;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        address.hashCode ^
        idOrPassport.hashCode ^
        password.hashCode ^
        type.hashCode;
  }
}
