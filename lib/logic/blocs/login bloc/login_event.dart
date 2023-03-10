import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  final String email;

  LoginEmailChanged({this.email});
@override
  // TODO: implement props
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({this.password});
  @override
  List<Object> get props => [password];
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String password;
  final String email;

  LoginWithCredentialsPressed(this.password, this.email);
  @override
  List<Object> get props => [email, password];
}

