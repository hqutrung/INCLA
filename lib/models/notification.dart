import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document/models/user_infor.dart';

class Noti {
  String content;
  String title;
  UserInfor usercreate;
  DateTime timestamp;
  int typeNoti;


  Noti.fromMap(Map data) {
    usercreate = UserInfor(userID: data['creatorID'], username: data['creatorName']);
    content = data['content'];
    timestamp = (data['timestamp'] as Timestamp).toDate();
    title = data['title'];
    typeNoti = data['typeNoti'];
  }

}
