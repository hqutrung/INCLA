import 'package:document/models/user.dart';
import 'package:document/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer();
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    String name = (user != null) ? user.name : 'loading';
    String email = (user != null) ? user.email : 'loading';
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text(email),
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
                print('signOut');
                // Navigator.popUntil(
                //   context,
                //   ModalRoute.withName(Navigator.defaultRouteName),
                // );
              }),
        ],
      ),
    );
  }
}