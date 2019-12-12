import 'user.dart';

class Student extends User {
  String anonymousName;
  Student.fromMap(Map data, String eml) : super.fromMap(data, email: eml) {
    anonymousName = data['anonymous_name'];
  }
}