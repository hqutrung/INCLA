import 'package:document/models/user.dart';
import 'package:document/screens/home_screen/widgets/home_main.dart';
import 'package:document/screens/home_screen/widgets/home_notification.dart';
import 'package:document/screens/home_screen/widgets/home_profile.dart';
import 'package:document/screens/shared_widgets/main_appbar.dart';
import 'package:document/screens/shared_widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String HOMESCREEN_PATH = '/home';
  HomePage();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static MainDrawer drawer = MainDrawer();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Widget> _widgetOptions = <Widget>[
    HomeMain(),
    HomeNotification(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("Home_Page rebuild");

    return Scaffold(
      appBar: AppBar(
          title: _selectedIndex == 0
              ? Text('Trang chủ')
              : _selectedIndex == 1
                  ? Text('Thông báo')
                  : Text('Thông tin cá nhân')),
      drawer: MainDrawer(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Trang chủ'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            title: Text('Thông báo'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Người dùng'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
