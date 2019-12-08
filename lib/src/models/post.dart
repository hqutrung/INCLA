import 'package:incla/models/attandance.dart';
import 'package:incla/models/comment.dart';

class Post {
  String uid;
  Attendance attendance;

  String content;
  List<Comment> comments;
  DateTime timestamp;
}