import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login/Registration'),
      ),
      body: Center(
        child: Column (
          children: [
            Center(
              child: Text('Hello ${user.email}')
            )
          ],
        ),
      )
    );
  }
}
