import 'package:firebase_bloc/data/repositories/user_repositories.dart';
import 'package:firebase_bloc/logic/blocs/authentication%20bloc/authentication_events.dart';
import 'package:firebase_bloc/logic/blocs/authentication%20bloc/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
   UserRepository _userRepository;
   AuthenticationBloc({UserRepository userRepository}):
     _userRepository = userRepository,
     super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if(event is AuthenticationStarted)  {
      yield* mapAuthenticationStartedtoState();
    }
    else if( event is AuthenticationLoggedIn) {
      yield* mapAuthenticationLoggedIntoState();
    }
    else if (event is AuthenticationLoggedOut){
      yield AuthenticationFailure();
    }
  }

   Stream<AuthenticationState> mapAuthenticationLoggedOuttoState () async * {
     yield AuthenticationFailure();
     _userRepository.signOut();
   }

  Stream<AuthenticationState> mapAuthenticationLoggedIntoState () async * {
    yield AuthenticationSuccess(await _userRepository.getCurrentUser());
  }

  Stream<AuthenticationState> mapAuthenticationStartedtoState () async* {
    final isSignedIn = await _userRepository.isSignedIn();
    if(isSignedIn) {
      final user = await _userRepository.getCurrentUser();
      yield AuthenticationSuccess(user);
    }
    else {
      yield AuthenticationFailure();
    }
  }

}