class Attendance {
  String userID;
  String username;

  Attendance.fromMap(Map data) {
    userID = data['userID'];
    username = data['username'];
  }
}