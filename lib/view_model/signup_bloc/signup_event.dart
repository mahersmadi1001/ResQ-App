import 'package:equatable/equatable.dart';
import 'package:projct/model/sign_up_model.dart';

class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendSigup extends SignupEvent {
  final SignUpModel signUpModel;

  SendSigup({required this.signUpModel});

  @override
  List<Object?> get props => [signUpModel];
}
