import 'package:flutter/material.dart';

class showDrawer extends StatelessWidget {
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
            onTap: (){},
          )
        ],
      ),
    );
  }
}