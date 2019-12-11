import 'package:cloud_firestore/cloud_firestore.dart';

import 'attandance.dart';
import 'comment.dart';

class Post {
  String uid;
  Attendance attendance;

  String title;
  String content;
  List<Comment> comments;
  DateTime timestamp;

  Post.fromMap(Map data, {this.uid}) {
    attendance = Attendance(userID: data['userID'], username: data['username']);
    timestamp = (data['timestamp'] as Timestamp).toDate();
    content = data['content'];
    title = data['title'];
    comments = (data['comments'] as List ?? []).map((c) {
      return Comment.fromMap(c);
    }).toList();
  }
}
