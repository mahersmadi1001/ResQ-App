// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignUpModel {
  String firstName;
  String lastName;
  String email;
  String address;
  String officialIdentifier;
  String officialIdentifierMethod;
  String password;
  String passwordConfirmation;
  SignUpModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.officialIdentifier,
    required this.officialIdentifierMethod,
    required this.password,
    required this.passwordConfirmation,
  });

  SignUpModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? address,
    String? officialIdentifier,
    String? officialIdentifierMethod,
    String? password,
    String? passwordConfirmation,
  }) {
    return SignUpModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      address: address ?? this.address,
      officialIdentifier: officialIdentifier ?? this.officialIdentifier,
      officialIdentifierMethod:
          officialIdentifierMethod ?? this.officialIdentifierMethod,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'address': address,
      'official_identifier_method': officialIdentifierMethod,
      'official_identifier': officialIdentifier,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      firstName: map['first_name'] as String? ?? map['firstName'] as String,
      lastName: map['last_name'] as String? ?? map['lastName'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      officialIdentifier:
          map['official_identifier'] as String? ??
          map['idOrPassport'] as String,
      officialIdentifierMethod:
          map['official_identifier_method'] as String? ?? 'national_id',
      password: map['password'] as String,
      passwordConfirmation:
          map['password_confirmation'] as String? ?? map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpModel.fromJson(String source) =>
      SignUpModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignUpModel(firstName: $firstName, lastName: $lastName, email: $email, address: $address, officialIdentifier: $officialIdentifier, officialIdentifierMethod: $officialIdentifierMethod, password: $password, passwordConfirmation: $passwordConfirmation)';
  }

  @override
  bool operator ==(covariant SignUpModel other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.address == address &&
        other.officialIdentifier == officialIdentifier &&
        other.officialIdentifierMethod == officialIdentifierMethod &&
        other.password == password &&
        other.passwordConfirmation == passwordConfirmation;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        address.hashCode ^
        officialIdentifier.hashCode ^
        officialIdentifierMethod.hashCode ^
        password.hashCode ^
        passwordConfirmation.hashCode;
  }
}
