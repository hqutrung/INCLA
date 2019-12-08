import 'package:document/screens/shared_widgets/main_appbar.dart';
import 'package:document/screens/shared_widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomeNotification extends StatefulWidget {
  @override
  _HomeNotificationState createState() => _HomeNotificationState();
}

class _HomeNotificationState extends State<HomeNotification> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: MainAppBar(
          title: 'Thông báo',
          openDrawer: () => _scaffoldKey.currentState.openDrawer(),
        ),
        drawer: MainDrawer(),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) => Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/logo-uit.png'),
              ),
              title: Text('New topic đã được tạo'),
              subtitle: Text(
                  'Huỳnh Quốc Trung đã tạo 1 topic mới trong lớp SE312.K11'),
              trailing: Text('2h'),
              onTap: () {
                //Navigator.push(context,MaterialPageRoute(builder: (context) => CourseScreen()));
              },
            ),
          ),
        ));
  }
}
