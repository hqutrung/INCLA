import 'package:document/models/session.dart';
import 'package:document/screens/session_screen/session_screen.dart';
import 'package:document/services/collection_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class SessionList extends StatelessWidget {
  Stream<List<Session>> sessionStream;

  SessionList({String courseID}) {
    sessionStream = Collection<Session>(path: 'course/$courseID/session').streamData();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Session>>(
      stream: sessionStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
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
                              builder: (context) => SessionScreen()));
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
