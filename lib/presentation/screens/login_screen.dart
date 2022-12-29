import 'package:firebase_bloc/data/repositories/user_repositories.dart';
import 'package:firebase_bloc/logic/blocs/login%20bloc/login_bloc.dart';
import 'package:firebase_bloc/presentation/screens/login_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const LoginScreen({Key key, UserRepository userRepository}) : _userRepository = userRepository, super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Tutorial')
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(userRepository: _userRepository,),
      )
    );
  }
}
