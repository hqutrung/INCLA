import 'package:document/models/course.dart';
import 'package:document/models/session.dart';
import 'package:document/models/user.dart';
import 'package:document/screens/session_screen/widget_session_screen/ratedetail.dart';
import 'package:document/screens/session_screen/widget_session_screen/rollcall.dart';
import 'package:document/screens/session_screen/widget_session_screen/test_list.dart';
import 'package:document/screens/session_screen/widget_session_screen/topic.dart';
import 'package:document/screens/shared_widgets/confirm_dialog.dart';
import 'package:document/services/firestore_helper.dart';
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
    User user = Provider.of<User>(context, listen: false);
    return Provider<Course>.value(
      value: widget.course,
      child: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                widget.session.topic,
                style: TextStyle(fontSize: 16.0),
              ),
              actions: <Widget>[
                (widget.session.endTime != null ||
                        user.type == UserType.Student)
                    ? Container()
                    : IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => confirmDialog(
                            context, 'Xác nhận kết thúc buổi học?', () {
                          FireStoreHelper()
                              .endSession(widget.course, widget.session.id);
                          setState(() {
                            widget.session.endTime = DateTime.now();
                          });
                        }),
                      )
              ],
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.comment),
                    text: "Thảo luận",
                  ),
                  Tab(
                    icon: Icon(Icons.assignment_turned_in),
                    text: "Kiểm tra",
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
                showTest(
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
