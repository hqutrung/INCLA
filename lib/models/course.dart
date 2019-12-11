import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Course {
  String courseID;
  String name;
  DocumentReference docReference;

  Course.fromMap(Map data, {this.courseID, @required this.docReference}) {
    if (courseID == null) courseID = data['courseID'];
    name = data['name'];
  }
}
