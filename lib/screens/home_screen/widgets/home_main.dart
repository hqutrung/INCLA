import 'package:document/models/course.dart';
import 'package:document/models/user.dart';
import 'package:document/screens/course_screen/course_screen.dart';
import 'package:document/screens/shared_widgets/main_appbar.dart';
import 'package:document/screens/shared_widgets/main_drawer.dart';
import 'package:document/services/auth_service.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeMain extends StatefulWidget {

  const HomeMain({Key key, }) : super(key: key);
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {

  Future<List<Course>> coursesNe;

  @override
  void initState() {
    User user = Provider.of<User>(context, listen: false);
    coursesNe = FireStoreHelper().getCourses(user.uid);
    super.initState();
  }

  Widget _buildListCourse(List<Course> course) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: course.length,
      itemBuilder: (BuildContext context, int index) => Card(
        child: ListTile(
          leading: Text(course[index].courseID),
          title: Text(course[index].name),
          subtitle: Text(course[index].teachername),
          // trailing: Icon(
          //   Icons.hotel,
          //   color: Colors.black,
          // ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseScreen(
                  course: course[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print("HomeMain build");
    return Scaffold(
      
      body: FutureBuilder(
        future: coursesNe,
        builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());
          else
            return _buildListCourse(snapshot.data);
        },
      ),
    );
  }
}
