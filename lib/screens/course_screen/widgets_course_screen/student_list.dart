import 'package:document/models/user_infor.dart';
import 'package:document/models/course.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList>
    with AutomaticKeepAliveClientMixin {
  Course course;

  @override
  void initState() {
    course = Provider.of<Course>(context, listen: false);
    super.initState();
  }

  Widget _buildStudentList(List<UserInfor> members) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: members.length,
      itemBuilder: (BuildContext context, int index) => Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo-uit.png'),
            backgroundColor: Colors.white,
          ),
          title: Text(members[index].username),
          subtitle: Text('MSSV: ${members[index].userID}'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<UserInfor> members = course.cachedStudents;
    if (course.cachedStudents == null)
      return FutureBuilder(
        future: course.getAllMembersAsync(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null)
              return Text('Lớp chưa đăng ký học sinh nào');
            else
              return _buildStudentList(snapshot.data);
          } else
            return Text('Loading');
        },
      );
    else
      return _buildStudentList(members);
  }

  @override
  bool get wantKeepAlive => true;
}
