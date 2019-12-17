import 'package:document/models/course.dart';
import 'package:document/models/session.dart';
import 'package:document/screens/session_screen/session_screen.dart';
import 'package:document/screens/shared_widgets/confirm_dialog.dart';
import 'package:document/services/collection_firestore.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionList extends StatefulWidget {
  SessionList();

  @override
  _SessionListState createState() => _SessionListState();
}

class _SessionListState extends State<SessionList> {
  Stream<List<Session>> sessionStream;
  Course course;

  void initState() {
    course = Provider.of<Course>(context, listen: false);
    sessionStream =
        Collection<Session>(path: 'course/${course.courseID}/session')
            .streamData();
    super.initState();
  }

  showAddSessionDialog(BuildContext context, Course course) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          TextEditingController _textEditingController =
              TextEditingController();
          return AlertDialog(
            content: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Nội dung buổi học',
                  ),
                ))
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              FlatButton(
                  child: const Text('Lưu'),
                  onPressed: () {
                    FireStoreHelper()
                        .createSession(course, _textEditingController.text);
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  showEditSessionDialog(BuildContext context, Course course, String topic,
      String sessionID) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          TextEditingController _textEditingController =
              TextEditingController(text: topic);
          return AlertDialog(
            content: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Nội dung buổi học',
                  ),
                ))
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              FlatButton(
                  child: const Text('Lưu'),
                  onPressed: () {
                    FireStoreHelper().updateSession(
                        course, _textEditingController.text, sessionID);
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Course course = Provider.of<Course>(context);
    return StreamBuilder<List<Session>>(
      stream: sessionStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                showAddSessionDialog(context, course);
              },
              label: Text('Tạo buổi'),
              icon: Icon(Icons.add),
            ),
            body: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) => Card(
                child: Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  child: ListTile(
                    title: Text(snapshot.data[index].topic),
                    subtitle: Text(snapshot.data[index].startTime.toString()),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SessionScreen(
                            course: course,
                            session: snapshot.data[index],
                          ),
                        ),
                      );
                    },
                  ),
                  actions: <Widget>[
                    IconSlideAction(
                      color: Colors.red,
                      icon: Icons.delete_outline,
                      onTap: () {
                        confirmDialog(context, 'Xác nhận xóa buổi học?', () {
                          FireStoreHelper()
                              .deleteSession(course, snapshot.data[index].id);
                        });
                      },
                    ),
                    IconSlideAction(
                      color: Colors.green,
                      icon: Icons.edit,
                      onTap: () {
                        showEditSessionDialog(
                            context,
                            course,
                            snapshot.data[index].topic,
                            snapshot.data[index].id);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else
          return Text('Loading... ' + snapshot.connectionState.toString());
      },
    );
  }
}
