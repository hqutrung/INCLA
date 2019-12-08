import 'package:document/screens/home_screen/widgets/home_main.dart';
import 'package:document/screens/home_screen/widgets/home_notification.dart';
import 'package:document/screens/home_screen/widgets/home_profile.dart';
import 'package:document/screens/shared_widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String HOMESCREEN_PATH = '/home';
  HomePage();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static Widget appBar(String titleApp) {
    return AppBar(
      title: Text(titleApp),
    );
  }

  void signOut() async {
    // try {
    //   await widget.auth.signOut();
    //   widget.logoutCallback();
    // } catch (e) {
    //   print(e);
    // }
  }


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
    return Scaffold(
      drawer: MainDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
