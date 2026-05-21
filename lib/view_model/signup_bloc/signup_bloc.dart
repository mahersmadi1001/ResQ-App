import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projct/core/erorr/erorr_handling.dart';
import 'package:projct/service/auth_service.dart';

import 'package:projct/view_model/signup_bloc/signup_event.dart';
import 'package:projct/view_model/signup_bloc/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthService authService;
  SignupBloc({required this.authService}) : super(InitState()) {
    on<SendSigup>(_onSendSignup);
  }

  Future<void> _onSendSignup(SendSigup event, Emitter<SignupState> emit) async {
    emit(LoadingState());

    try {
      final result = await authService.signUp(event.signUpModel);
      emit(SucssfoledState(sucssfoledMassege: result));
    } on Failure catch (e) {
      emit(ErorrState(ErorrMassege: e.message));
    } catch (e) {
      emit(ErorrState(ErorrMassege: "حدث خطأ غير متوقع: ${e.toString()}"));
    }
  }
}
