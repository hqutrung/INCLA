import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document/models/user_infor.dart';

class Result {
  UserInfor attendance;
  int point;
  DateTime time;
  List<int> answers;

  Result.fromMap(Map data) {
    attendance = UserInfor(userID: data['userID'], username: data['username']);
    point = data['point'];
    time = (data['time'] as Timestamp).toDate();
    answers = (data['answers'].cast<int>() as List ?? []).toList();
  }
}