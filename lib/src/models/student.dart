import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:incla/models/user.dart';

class Student extends User {
  String anonymousName;
  Student.fromMap(Map data, String eml, DocumentReference docRef) : super.fromMap(data, email: eml, documentReference: docRef) {
    anonymousName = data['anonymous_name'];
  }
}