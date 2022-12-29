import 'package:firebase_bloc/data/repositories/user_repositories.dart';
import 'package:firebase_bloc/logic/blocs/authentication%20bloc/authentication_bloc.dart';
import 'package:firebase_bloc/logic/blocs/simple_bloc_observer.dart';
import 'package:firebase_bloc/presentation/screens/home_page.dart';
import 'package:firebase_bloc/presentation/screens/login_screen.dart';
import 'package:firebase_bloc/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'logic/blocs/authentication bloc/authentication_state.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BlocProvider(
    create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: MyApp(userRepository: userRepository )
  )
  );
}



class MyApp extends StatefulWidget {
  final UserRepository _userRepository;

  MyApp({UserRepository userRepository}) : _userRepository = userRepository;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot){
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          getPages: AppRoutes.pages,
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if(state is AuthenticationFailure){
                return LoginScreen();
              }
              if(state is AuthenticationSuccess){
                return HomePage(user: state.firebaseUser,);
              }
              return Scaffold(
                appBar: AppBar(),
                body: Container(
                  child: Center(child: Text('Loading')),
                ),
              );
            },
          ),
        );
      },
    );
  }
}