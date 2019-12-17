import 'package:document/models/course.dart';
import 'package:document/models/session.dart';
import 'package:document/screens/session_screen/widget_session_screen/ratedetail.dart';
import 'package:document/screens/session_screen/widget_session_screen/rollcall.dart';
import 'package:document/screens/session_screen/widget_session_screen/topic.dart';

import 'package:document/screens/shared_widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionScreen extends StatefulWidget {
  final Course course;
  final Session session;

  SessionScreen({@required this.course, @required this.session});
  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Provider<Course>.value(
      value: widget.course,
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Tuần 1 - Ngày 10/10/2019',
                style: TextStyle(fontSize: 16.0),
              ),
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
                showTopic(
                  course: widget.course,
                  sessionID: widget.session.id,
                ),
                RollCall(sessionID: widget.session.id),
                RateDetail(session: widget.session),
              ],
            ),
          )),
    );
  }
}
