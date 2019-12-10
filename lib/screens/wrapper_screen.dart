import 'package:document/models/user.dart';
import 'package:document/screens/home_screen/home_page.dart';
import 'package:document/screens/login_screen/login_screen.dart';
import 'package:document/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginAndHomeWrapper extends StatelessWidget {
  static const String WRAPPER_PATH = '/';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: AuthService().getUser,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data;
            if (user == null)
              return LoginScreen();
            else
              return HomePage();
          } else
            return Text('Loading...');
        });
  }
}
