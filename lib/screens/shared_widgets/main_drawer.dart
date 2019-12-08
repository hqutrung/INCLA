import 'package:flutter/material.dart'; 
 
class MainDrawer extends StatefulWidget { 
  final Function signOut; 
  MainDrawer({this.signOut}); 
  @override 
  _MainDrawerState createState() => _MainDrawerState(); 
} 
 
class _MainDrawerState extends State<MainDrawer> { 
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
            onTap: widget.signOut, 
          ) 
        ], 
      ), 
    ); 
  } 
} 
