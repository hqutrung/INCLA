import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document/models/attandance.dart';

class Comment {
  Attendance attendance;
  String content;
  DateTime timestamp;

  Comment.fromMap(Map data) {
    attendance = Attendance(userID: data['userID'], username: data['username']);
    content = data['content'];
    timestamp = (data['timestamp'] as Timestamp).toDate();
  }
}