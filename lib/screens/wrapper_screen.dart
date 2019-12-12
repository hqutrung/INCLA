import 'package:document/models/user.dart';
import 'package:document/screens/home_screen/home_page.dart';
import 'package:document/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginAndHomeWrapper extends StatelessWidget {
  static const String WRAPPER_PATH = '/';

  @override
  Widget build(BuildContext context) {
    print("LoginAndHomeWrapper build");
    User user = Provider.of<User>(context);
    if (user == null) return LoadingPage();
    if (user.email == null)
      return LoginScreen();
    else
      return HomePage();
  }
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
