import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projct/core/erorr/erorr_handling.dart';
import 'package:projct/service/auth_service.dart';
import 'package:projct/view_model/otp_bloc/otp_event.dart';
import 'package:projct/view_model/otp_bloc/otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  AuthService authService;
  OtpBloc({required this.authService}) : super(OtpInitState()) {
    on<SendOtp>((event, emit) async {
      try {
        emit(OtpLoadingState());
        bool resul = await authService.sendOtp(email: event.email);

        if (resul == true) {
          emit(SuccessSendOtp());
        }
      } on Failure catch (e) {
        emit(OtpError(message: e.message));
      }
    });

    on<VerifyOtp>((event, emit) async {
      try {
        emit(OtpLoadingState());
        bool result = await authService.verifyOtp(
          email: event.email,
          otp: event.code,
        );

        if (result == true) {
          emit(OtpIsVerify());
        }
      } on Failure catch (e) {
        emit(OtpError(message: e.message));
      }
    });
  }
}
