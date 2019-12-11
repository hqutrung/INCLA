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
    if (user == null) return Text("Loading...");//LoadingPage();
    if (user.email == null)
      print("LoginAndHomeWrapper with user.email == null");
    if (user.email == null) {
      print("rebuild with loginScreen");
      return LoginScreen();
    } else {
      print("Rebuild with HomePage");
      return HomePage();
    }
  }
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: Colors.blue,
    );
  }
}
