import 'package:document/screens/home_screen/home_page.dart';
import 'package:document/screens/wrapper_screen.dart';
import 'package:document/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value: AuthService().userStream),
      ],
      child: MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          LoginAndHomeWrapper.WRAPPER_PATH: (_) => LoginAndHomeWrapper(),
          HomePage.HOMESCREEN_PATH: (_) => HomePage(),
        },
      ),
    );
  }
}
