import 'package:flutter/material.dart';

class Attendance {
  String userID;
  String username;

  Attendance({@required this.userID, @required this.username});

  Attendance.fromMap(Map data) {
    userID = data['userID'];
    username = data['username'];
  }
}