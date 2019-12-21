import 'package:document/models/course.dart';
import 'package:document/screens/course_screen/widgets_course_screen/session_list.dart';
import 'package:document/screens/course_screen/widgets_course_screen/course_resources.dart';
import 'package:document/screens/course_screen/widgets_course_screen/statistical.dart';
import 'package:document/screens/course_screen/widgets_course_screen/student_list.dart';
import 'package:document/models/user.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseScreen extends StatefulWidget {
  final Course course;

  CourseScreen({@required this.course});

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildStudentCourseScreen() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                widget.course.name,
              )),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.content_paste),
                text: "Buổi học",
              ),
              Tab(
                icon: Icon(Icons.person),
                text: "Sinh viên",
              ),
              Tab(
                icon: Icon(Icons.description),
                text: "Tài liệu",
              ),
            ],
          ),
        ),
        body: Provider<Course>.value(
          value: widget.course,
          child: TabBarView(
            children: <Widget>[
              SessionList(),
              StudentList(),
              CourseResources(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeacherCourseScreen() {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Phương pháp phát triển phần mềm hướng đối tượng'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.content_paste),
                text: "Buổi học",
              ),
              Tab(
                icon: Icon(Icons.person),
                text: "Sinh viên",
              ),
              Tab(
                icon: Icon(Icons.description),
                text: "Tài liệu",
              ),
              Tab(
                icon: Icon(Icons.insert_chart),
                text: "Thống kê",
              ),
            ],
          ),
        ),
        body: Provider<Course>.value(
          value: widget.course,
          child: TabBarView(
            children: <Widget>[
              SessionList(),
              StudentList(),
              CourseResources(),
              RateChart()
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    return Provider.value(
      value: widget.course,
      child: user.type == UserType.Teacher
          ? _buildTeacherCourseScreen()
          : _buildStudentCourseScreen(),
    );
  }
}
