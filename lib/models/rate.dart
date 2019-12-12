import 'user_infor.dart';

class Rate {
  UserInfor attendance;
  int star;
  String content;

  Rate.fromMap(Map data) {
    attendance = UserInfor(
      userID: data['userID'],
      username: data['username'],
    );
    star = data['value'];
    content = data['content'];
  }
}
