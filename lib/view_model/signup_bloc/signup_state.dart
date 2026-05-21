import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitState extends SignupState {}

class LoadingState extends SignupState {}

class ErorrState extends SignupState {
  String ErorrMassege;
  ErorrState({required this.ErorrMassege});
}

class SucssfoledState extends SignupState {
  String sucssfoledMassege;
  SucssfoledState({required this.sucssfoledMassege});
}
