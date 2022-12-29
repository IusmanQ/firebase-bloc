import 'package:firebase_bloc/presentation/screens/login_screen.dart';
import 'package:firebase_bloc/presentation/screens/register_screen.dart';
import 'package:get/get.dart';
class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
        name: '/login', page: () => LoginScreen()
    ),
    GetPage(
        name: '/signup', page: () => RegisterScreen()
    ),
  ];
}