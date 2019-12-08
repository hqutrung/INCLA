import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:incla/models/user.dart';

class Teacher extends User {
  String degree;

  Teacher.fromMap(Map data, String eml, DocumentReference docRef) 
  : super.fromMap(data, email: eml, documentReference: docRef) {
    degree = data['degree'];
  }
}