import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Course {
  String courseID;
  String name;

  Course.fromMap(Map data, {this.courseID}) {
    if (courseID == null) courseID = data['courseID'];
    name = data['name'];
  }
}
