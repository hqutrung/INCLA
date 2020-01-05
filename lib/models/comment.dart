import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document/models/user_infor.dart';

class Comment {
  UserInfor attendance;
  String content;
  DateTime timestamp;

  Comment.fromMap(Map data) {
   
    attendance = UserInfor(userID: data['userID'], username: data['username']);
    content = data['content'];
    timestamp = (data['timestamp'] as Timestamp).toDate();
  }
}
