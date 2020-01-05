import 'package:document/models/user.dart';
import 'package:document/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorThemeNotifier with ChangeNotifier {
  MaterialColor color;

  ColorThemeNotifier(this.color);

  MaterialColor getColor() => color;

  setTheme(MaterialColor _color) async {
    color = _color;
    notifyListeners();
  }
}

class MainDrawer extends StatelessWidget {
  MainDrawer();

  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    print("Main Drawer rebuild");
    User user = Provider.of<User>(context, listen: false);
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
                Navigator.pop(context);
              }),
          Divider(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  final colorthemeNotifier =
                      Provider.of<ColorThemeNotifier>(context);
                  colorthemeNotifier.setTheme(Colors.red);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                ),
              ),
              GestureDetector(
                onTap: () {
                  final colorthemeNotifier =
                      Provider.of<ColorThemeNotifier>(context);
                  colorthemeNotifier.setTheme(Colors.blue);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                ),
              ),
              GestureDetector(
                onTap: () {
                  final colorthemeNotifier =
                      Provider.of<ColorThemeNotifier>(context);
                  colorthemeNotifier.setTheme(Colors.cyan);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.cyan,
                ),
              ),
              GestureDetector(
                onTap: () {
                  final colorthemeNotifier =
                      Provider.of<ColorThemeNotifier>(context);
                  colorthemeNotifier.setTheme(Colors.pink);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.pink,
                ),
              ),
              GestureDetector(
                onTap: () {
                  final colorthemeNotifier =
                      Provider.of<ColorThemeNotifier>(context);
                  colorthemeNotifier.setTheme(Colors.deepOrange);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
