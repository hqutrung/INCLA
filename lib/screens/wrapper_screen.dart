import 'package:document/models/user.dart';
import 'package:document/screens/home_screen/home_page.dart';
import 'package:document/screens/login_screen/login_screen.dart';
import 'package:document/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginAndHomeWrapper extends StatelessWidget {
  static const String WRAPPER_PATH = '/';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: AuthService().getUser,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Text('Loading...');
          else {
            User user = snapshot.data;
            if (user.email == null)
              return LoginScreen();
            else
              return HomePage();
          }
          // return Text('Loading... ' + snapshot.connectionState.toString() + ' ' + snapshot.hasData.toString());
        });
  }
}
