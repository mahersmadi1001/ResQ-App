import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projct/core/erorr/erorr_handling.dart';
import 'package:projct/service/auth_service.dart';
import 'package:projct/view_model/logout_bloc/logout_event.dart';
import 'package:projct/view_model/logout_bloc/logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthService authService;

  LogoutBloc({required this.authService}) : super(LogoutInitState()) {
    on<SendLogout>((event, emit) async {
      try {
        emit(LogoutLoadingState());
        await authService.logout();
        emit(LogoutSuccessState());
      } on Failure catch (e) {
        emit(LogoutErrorState(message: e.message));
      }
    });
  }
}
