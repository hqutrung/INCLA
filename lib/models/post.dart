

import 'package:document/models/attandance.dart';
import 'package:document/models/comment.dart';

class Post {
  String uid;
  Attendance attendance;

  String content;
  List<Comment> comments;
  DateTime timestamp;
}