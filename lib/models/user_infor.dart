import 'package:flutter/material.dart';

class UserInfor {
  String userID;
  String username;

  UserInfor({@required this.userID, @required this.username});

  UserInfor.fromMap(Map data) {
    userID = data['userID'];
    username = data['username'];
  }
}