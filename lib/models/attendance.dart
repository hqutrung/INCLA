import 'package:document/models/user_infor.dart';

class Attendance {
  static const String OFFLINE_FIELD = 'offline';
  static const String ONLINE_FIELD = 'online';

  List<UserInfor> offline;
  List<UserInfor> online;

  Attendance.fromMap(Map data) {
    offline = (data[OFFLINE_FIELD] as List ?? [])
        .map((value) => UserInfor.fromMap(value));
    online = (data[ONLINE_FIELD] as List ?? [])
        .map((value) => UserInfor.fromMap(value));
  }
}
