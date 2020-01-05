import 'package:document/models/user.dart';
import 'package:flutter/material.dart';

class UserInfor {
  String userID;
  String username;
  UserType userType;

  UserInfor({@required this.userID, @required this.username});

  UserInfor.fromMap(Map data) {
    userID = data['userID'];
    username = data['username'];
  }
}
