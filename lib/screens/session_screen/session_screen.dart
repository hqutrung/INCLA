import 'package:document/screens/session_screen/widget_session_screen/rollcall.dart';
import 'package:document/screens/session_screen/widget_session_screen/topic.dart';
import 'package:document/screens/shared_widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class SessionScreen extends StatefulWidget {
  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: MainDrawer(),
          appBar: AppBar(
            title: Text('Tuần 1 - Ngày 10/10/2019'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.comment),
                  text: "Thảo luận",
                ),
                Tab(
                  icon: Icon(Icons.check_circle_outline),
                  text: "Điểm danh",
                ),
                
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              showTopic(),
              RollCall(),
            ],
          ),
        ));
  }
}
