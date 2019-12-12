import 'package:document/models/course.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateQR extends StatefulWidget {
  @override
  _CreateQRState createState() => _CreateQRState();
}

class _CreateQRState extends State<CreateQR> {
  @override
  Widget build(BuildContext context) {
    Course course = Provider.of<Course>(context);
    return GestureDetector(
      onTap: () {
        print('ontap');
        return FireStoreHelper().createAttendance(course: course, duration: 2);
      },
      child: Container(
        height: 250,
        width: 250,
        child: Icon(
          Icons.center_focus_weak,
          size: 250.0,
        ),
      ),
    );
  }
}
