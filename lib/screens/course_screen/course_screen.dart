import 'package:document/models/course.dart';
import 'package:document/screens/course_screen/widgets_course_screen/session_list.dart';
import 'package:document/screens/course_screen/widgets_course_screen/course_resources.dart';
import 'package:document/screens/course_screen/widgets_course_screen/statistical.dart';
import 'package:document/screens/course_screen/widgets_course_screen/student_list.dart';
import 'package:document/screens/shared_widgets/main_drawer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: widget.course,
      child: DefaultTabController(
          length: 4,
          child: Scaffold(
            drawer: MainDrawer(),
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
          )),
    );

    // body: ListView.builder(
    //   scrollDirection: Axis.vertical,
    //   itemCount: 3,
    //   itemBuilder: (BuildContext context, int index) {
    //     return Container(
    //       padding: EdgeInsets.all(10),
    //       child: RaisedButton(
    //         onPressed: () {
    //           Navigator.push(context,
    //               MaterialPageRoute(builder: (context) => CourseScreen()));
    //         },
    //         padding: EdgeInsets.all(10),
    //         color: Colors.white,
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(10)),
    //         child: Text('Tuần $index - Ngày 22/11/2019'),
    //         )
    //     );
    //   },
    // ));
  }
}
