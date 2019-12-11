import 'package:document/models/course.dart';
import 'package:document/models/session.dart';
import 'package:document/screens/session_screen/session_screen.dart';
import 'package:document/services/collection_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class SessionList extends StatelessWidget {
  final Course course;
  Stream<List<Session>> sessionStream;

  SessionList({@required this.course}) {
    sessionStream =
        Collection<Session>(path: 'course/${course.courseID}/session')
            .streamData();
  }

  showAddSessionDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          var _textEditingController;
          return AlertDialog(
            content:  Row(
              children: <Widget>[
                 Expanded(
                    child:  TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration:  InputDecoration(
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
                   // addTodo(_textEditingController.text.toString());
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Session>>(
      stream: sessionStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                showAddSessionDialog(context);
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
                            sessionID: snapshot.data[index].id,
                          ),
                        ),
                      );
                    },
                  ),
                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'Xoá',
                      color: Colors.red,
                      icon: Icons.delete_outline,
                      onTap: () {},
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
