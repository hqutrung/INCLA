import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  String courseID;
  String name;
  DocumentReference reference;

  Course.fromMap(Map data, {this.courseID, this.reference}) {
    if (courseID == null) courseID = data['courseID'];
    name = data['name'];
  }
}
