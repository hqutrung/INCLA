import 'package:cloud_firestore/cloud_firestore.dart';

import 'attandance.dart';
import 'rate.dart';

enum SessionState {
  Inactive,
  Active,
}

class Session {
  DateTime startTime;
  DateTime endTime;
  String topic;
  List<Attendance> attendances;
  List<Rate> rates;
  SessionState state;

  Session.fromMap(Map data) {
    startTime = (data['start'] as Timestamp).toDate();
    endTime = (data['end'] as Timestamp).toDate();
    topic = data['topic'];
    attendances = (data['attendance'] as List ?? []).map((a) => Attendance.fromMap(a)).toList();
    rates = (data['rates'] as List ?? []).map((a) => Rate.fromMap(a)).toList();
    if (DateTime.now().isAfter(endTime))
      state = SessionState.Inactive;
    else
      state = SessionState.Active;
  }
}