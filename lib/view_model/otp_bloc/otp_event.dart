
import 'package:equatable/equatable.dart';

class OtpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendOtp extends OtpEvent {
  String email;

  SendOtp({required this.email});
  @override
  List<Object?> get props => [email];
}

class VerifyOtp extends OtpEvent {
  String email;
  String code;
  VerifyOtp({required this.email, required this.code});
  @override
  List<Object?> get props => [email, code];
}
