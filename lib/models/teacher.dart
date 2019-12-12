import 'user.dart';

class Teacher extends User {
  String degree;

  Teacher.fromMap(Map data, String eml) 
  : super.fromMap(data, email: eml) {
    degree = data['degree'];
  }
}