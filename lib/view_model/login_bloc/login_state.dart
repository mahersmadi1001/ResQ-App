import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState({required this.message});

  @override

  
  List<Object?> get props => [message];
}

class LoginSuccessState extends LoginState {
  final String message;
  LoginSuccessState({required this.message});

  @override
  List<Object?> get props => [message];
}
