import 'package:document/screens/course_screen/widgets_course_screen/widget_buoihoc.dart';
import 'package:document/screens/course_screen/widgets_course_screen/widget_tailieu.dart';
import 'package:document/screens/course_screen/widgets_course_screen/widget_sinhvien.dart';
import 'package:document/screens/shared_widgets/main_drawer.dart';

import 'package:flutter/material.dart';

class CourseScreen extends StatefulWidget {
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: MainDrawer(),
          appBar: AppBar(
            title: Text('Phương pháp phát triển phần mềm hướng đối tượng'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.menu),
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
          body: TabBarView(
            children: <Widget>[
              showBuoiHoc(),
              showSinhVien(),
              showTaiLieu(),
            ],
          ),
        ));

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
