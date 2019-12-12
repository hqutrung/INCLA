import 'package:document/models/user.dart';
import 'package:document/screens/wrapper_screen.dart';
import 'package:document/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Stream<User> userStream;

  @override
  void initState() {
    userStream = AuthService().getUserStream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: userStream,
      builder: (context, snapshot) {
        return Provider<User>.value(
          value: snapshot.data,
          child: MaterialApp(
            title: 'Incla',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: {
              LoginAndHomeWrapper.WRAPPER_PATH: (_) => LoginAndHomeWrapper(),
              // HomePage.HOMESCREEN_PATH: (_) => HomePage(),
            },
          ),
        );
      },
    );
  }
}
