import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projct/core/erorr/erorr_handling.dart';
import 'package:projct/service/auth_service.dart';
import 'package:projct/view_model/login_bloc/login_event.dart';
import 'package:projct/view_model/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  LoginBloc({required this.authService}) : super(LoginInitState()) {
    on<SendLogin>((event, emit) async {
      try {
        emit(LoginLoadingState());
        String message = await authService.login(event.loginModel);
        emit(LoginSuccessState(message: message));
      } on Failure catch (e) {
        emit(LoginErrorState(message: e.message));
      }
    });
  }
}
