
import 'package:document/services/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback logoutCallback;

  const HomePage({Key key, this.auth, this.logoutCallback}) : super(key: key);
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
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  Widget showDrawer() {
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
            onTap: signOut,
          )
        ],
      ),
    );
  }

  static Widget showHome() {
    return Scaffold(
        appBar: appBar('Trang chủ'),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                onPressed: () {},
                padding: EdgeInsets.all(10),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[Text('SE314.K12')],
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Phap Luat Dai Cuong',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Nguyen Minh Hoang',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
            );
          },
        ));
  }

  static Widget showNoti() {
    return Scaffold(
        appBar: appBar('Thông báo'),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: RaisedButton(
                onPressed: () {},
                padding: EdgeInsets.all(10),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/logo-uit.png',
                          width: 40,
                          height: 40,
                        )
                      ],
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Phap Luat Dai Cuong',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Nguyen Minh Hoang',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ]),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '2h',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ])
                  ],
                ),
              ),
            );
          },
        ));
  }

  static Widget showContact() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.call),
                SizedBox(
                  width: 120,
                ),
                Text('0375475075'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.call),
                SizedBox(
                  width: 120,
                ),
                Text('0375475075'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.call),
                SizedBox(
                  width: 120,
                ),
                Text('0375475075'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.call),
                SizedBox(
                  width: 120,
                ),
                Text('0375475075'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.call),
                SizedBox(
                  width: 120,
                ),
                Text('0375475075'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.call),
                SizedBox(
                  width: 120,
                ),
                Text('0375475075'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget showProfile() {
    return Scaffold(
        appBar: appBar('Thông tin cá nhân'),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 130.0,
                    child: const DecoratedBox(
                      decoration: const BoxDecoration(color: Colors.cyan),
                    ),
                  ),
                ],
              ),
              SafeArea(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage('assets/images/logo-uit.png'),
                      ),
                    ),
                    Text(
                      'Lê Thanh Trọng',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    showContact(),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  List<Widget> _widgetOptions = <Widget>[
    showHome(),
    showNoti(),
    showProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
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
