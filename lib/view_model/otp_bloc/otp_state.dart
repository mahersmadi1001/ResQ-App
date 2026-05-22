import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OtpInitState extends OtpState {}

class OtpLoadingState extends OtpState {}

class OtpError extends OtpState {
  final String message;
  OtpError({required this.message});
  
  @override
  List<Object?> get props => [message];
}

class SuccessSendOtp extends OtpState {}

class OtpIsVerify extends OtpState {}
