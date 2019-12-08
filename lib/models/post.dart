

import 'attandance.dart';
import 'comment.dart';

class Post {
  String uid;
  Attendance attendance;

  String content;
  List<Comment> comments;
  DateTime timestamp;
}