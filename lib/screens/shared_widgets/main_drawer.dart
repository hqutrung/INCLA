import 'package:document/screens/login_screen/login_screen.dart';
import 'package:document/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:collection/wrappers.dart';

import '../wrapper_screen.dart';

class MainDrawer extends StatefulWidget {
  MainDrawer();
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Ashish Rawat"),
            accountEmail: Text("ashishrawat2911@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/images/logo-uit.png',
                width: 40,
                height: 40,
              ),
            ),
          ),
          ListTile(
              title: Text('Đăng xuất'),
              onTap: () {
                auth.signOut();
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(Navigator.defaultRouteName),
                );
              }),
        ],
      ),
    );
  }
}
