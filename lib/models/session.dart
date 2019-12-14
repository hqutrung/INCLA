import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum SessionState {
  Inactive,
  Active,
}

class Session {
  String id;
  DateTime startTime;
  DateTime endTime;
  String topic;
  SessionState state;

  Session.fromMap(Map data, {@required this.id}) {
    startTime = (data['start'] as Timestamp).toDate();
    endTime = (data['end'] as Timestamp).toDate();
    topic = data['topic'];
    if (DateTime.now().isAfter(endTime))
      state = SessionState.Inactive;
    else
      state = SessionState.Active;
  }
}