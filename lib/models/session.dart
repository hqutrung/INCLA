import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'user_infor.dart';
import 'rate.dart';

enum SessionState {
  Inactive,
  Active,
}

class Session {
  String id;
  DateTime startTime;
  DateTime endTime;
  String topic;
  List<UserInfor> attendances;
  List<Rate> rates;
  SessionState state;

  Session.fromMap(Map data, {@required this.id}) {
    startTime = (data['start'] as Timestamp).toDate();
    endTime = (data['end'] as Timestamp).toDate();
    topic = data['topic'];
    attendances = (data['attendance'] as List ?? []).map((a) => UserInfor.fromMap(a)).toList();
    rates = (data['rates'] as List ?? []).map((a) => Rate.fromMap(a)).toList();
    if (DateTime.now().isAfter(endTime))
      state = SessionState.Inactive;
    else
      state = SessionState.Active;
  }
}