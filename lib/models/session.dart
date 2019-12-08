import 'attandance.dart';
import 'rate.dart';

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