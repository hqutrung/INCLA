import 'package:document/models/user.dart';
import 'package:document/screens/shared_widgets/main_drawer.dart';
import 'package:document/screens/wrapper_screen.dart';
import 'package:document/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ColorThemeNotifier>(
        child: MyApp(),
        create: (BuildContext context) => ColorThemeNotifier(Colors.blue)),
  );
}

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
    final colorthemeNotifier = Provider.of<ColorThemeNotifier>(context);
    return StreamBuilder<User>(
      stream: userStream,
      builder: (context, snapshot) {
        return Provider<User>.value(
          value: snapshot.data,
          child: MaterialApp(
            title: 'Incla',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: colorthemeNotifier.getColor(),
            ),
            routes: {
              LoginAndHomeWrapper.WRAPPER_PATH: (_) => LoginAndHomeWrapper(),
              // '/': (_) => ImportScreen(),
            },
          ),
        );
      },
    );
  }
}
