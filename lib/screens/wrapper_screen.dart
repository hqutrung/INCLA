import 'package:document/screens/home_screen/home_page.dart';
import 'package:document/screens/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginAndHomeWrapper extends StatelessWidget {
  static const String WRAPPER_PATH = '/';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            FirebaseUser user = snapshot.data;
            if (user == null)
              return LoginScreen();
            else
              return HomePage();
          }
          return LoginScreen();
        });
  }
}
