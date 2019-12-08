import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'course.dart';


enum UserType {
  Teacher,
  Student,
}

class User {
  static const String COLLECTION_PATH = 'user';

  Firestore _db = Firestore.instance;

  DocumentReference documentReference;

  String email;
  String uid;
  String name;
  List<Course> course;
  UserType type;

  User.fromMap(Map data, {@required this.documentReference, @required this.email}) {
    name = data['name'];
    uid = data['uid'];
    type = UserType.values[data['user_type']];
  }
}
