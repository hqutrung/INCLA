import 'package:incla/models/attandance.dart';
import 'package:incla/models/rate.dart';

enum SessionState {
  Inactive,
  Active,
}

class Session {
  DateTime startTime;
  DateTime endtime;
  List<Attendance> attendances;
  List<Rate> rates;
  SessionState state;
}