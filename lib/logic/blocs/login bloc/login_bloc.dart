import 'package:firebase_bloc/Utils/validators.dart';
import 'package:firebase_bloc/data/repositories/user_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final UserRepository _userRepository;
  LoginBloc({UserRepository userRepository}) : _userRepository = userRepository, super(LoginState.initial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginEmailChanged) {
      yield* _mapLoginEmailChangedtoState(event.email);
    }
    else if (event is LoginPasswordChanged) {
      yield* _mapLoginPasswordChangedtoState(event.password);
    }
    else if(event is LoginWithCredentialsPressed){
      yield* _mapLoginWithCredentialsPressedtoState(email: event.email, password: event.password);
    }
  }

  Stream<LoginState> _mapLoginEmailChangedtoState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email)
    );
  }

  Stream<LoginState> _mapLoginPasswordChangedtoState(String password) async* {
    yield state.update(
        isPasswordValid: Validators.isValidPassword(password)
    );
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedtoState({String email, String password}) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    }
    catch(e) {
      LoginState.failure();
    }
  }

}
