import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projct/view_model/signup/signup_state.dart';
import 'package:projct/view_model/signup/signup_event.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc(super.initialState);

  @override
  on<SendSigup>( 
    (){
      
    }
  );
}
