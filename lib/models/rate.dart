import 'attandance.dart';

class Rate {
  Attendance attendance;
  int star;
  String content;

  Rate.fromMap(Map data) {
    attendance = Attendance(
      userID: data['userID'],
      username: data['username'],
    );
    star = data['value'];
    content = data['content'];
  }
}
