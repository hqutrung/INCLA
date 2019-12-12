import 'package:document/models/attandance.dart';
import 'package:document/models/course.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> with AutomaticKeepAliveClientMixin {
  Future<List<Attendance>> studentsAsyncer;

  @override
  void initState() {
    Course course = Provider.of<Course>(context, listen: false);
    studentsAsyncer = FireStoreHelper().getStudents(course.courseID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Attendance>>(
        future: studentsAsyncer,
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

  @override
  bool get wantKeepAlive => true;
}
