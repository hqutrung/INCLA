import 'package:document/models/course.dart';
import 'package:document/models/session.dart';
import 'package:document/screens/session_screen/widget_session_screen/ratedetail.dart';
import 'package:document/screens/session_screen/widget_session_screen/rollcall.dart';
import 'package:document/screens/session_screen/widget_session_screen/topic.dart';


import 'package:document/screens/shared_widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class SessionScreen extends StatefulWidget {
  final Course course;
  final String sessionID;

  SessionScreen({@required this.course, @required this.sessionID});
  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override


  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: MainDrawer(),
          appBar: AppBar(
            title: Text(
              'Tuần 1 - Ngày 10/10/2019',
              style: TextStyle(fontSize: 16.0),
            ),
            actions: <Widget>[
              SizedBox(
                height: 10,
                width: 80,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Row(
                    children: <Widget>[
                      Text('5.0'),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      )
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ],
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
                Tab(
                  icon: Icon(Icons.star),
                  text: "Đánh giá",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              showTopic(course: widget.course, sessionID: widget.sessionID,),
              RollCall(),
              RateDetail()
            ],
          ),
        ));
  }
}
