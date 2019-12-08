
import 'package:document/screens/home_page.dart';
import 'package:document/screens/loginScreen/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        LoginScreen.LOGINSCREEN_PATH: (_) => LoginScreen(),
        HomePage.HOMESCREEN_PATH: (_) => HomePage(),
      },
    );
  }
}
