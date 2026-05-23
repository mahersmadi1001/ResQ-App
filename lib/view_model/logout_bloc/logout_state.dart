import 'package:equatable/equatable.dart';

abstract class LogoutState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LogoutInitState extends LogoutState {}

class LogoutLoadingState extends LogoutState {}

class LogoutErrorState extends LogoutState {
  final String message;
  LogoutErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LogoutSuccessState extends LogoutState {}
