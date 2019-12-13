import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document/models/user_infor.dart';
import 'package:flutter/material.dart';

class Attendance {
  static const String OFFLINE_FIELD = 'offline';
  static const String ONLINE_FIELD = 'online';

  DocumentReference reference;

  List<UserInfor> offline;
  List<UserInfor> online;
  int duration;
  DateTime timestamp;

  Attendance.fromMap(Map data, {@required this.reference}) {
    offline = (data[OFFLINE_FIELD] as List ?? [])
        .map((value) => UserInfor.fromMap(value)).toList();
    online = (data[ONLINE_FIELD] as List ?? [])
        .map((value) => UserInfor.fromMap(value)).toList();
    duration = data['duration'];
  }
}
