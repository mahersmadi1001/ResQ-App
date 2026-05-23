import 'package:equatable/equatable.dart';
import 'package:projct/model/login_model.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendLogin extends LoginEvent {
  final LoginModel loginModel;

  SendLogin({required this.loginModel});

  @override
  List<Object?> get props => [loginModel];
}
