import 'package:document/models/attandance.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';

class StudentList extends StatelessWidget {
  final String courseID;
  Future<List<Attendance>> attendanceAsyncer;

  StudentList({@required this.courseID}) {
    print("1");
    attendanceAsyncer = FireStoreHelper().getStudents(this.courseID);
  }

  @override
  Widget build(BuildContext context) {
    print("2");
    return FutureBuilder<List<Attendance>>(
        future: attendanceAsyncer,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('Loading');
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo-uit.png'),
                  backgroundColor: Colors.white,
                ),
                title: Text(snapshot.data[index].username),
                subtitle: Text('MSSV: ${snapshot.data[index].userID}'),
              ),
            ),
          );
        });
  }
}
