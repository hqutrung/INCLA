import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'comment.dart';
import 'user_infor.dart';

class Post {
  String uid;
  UserInfor attendance;

  String title;
  String content;
  List<Comment> comments;
  DateTime timestamp;

  Post.fromMap(Map data, {@required this.uid}) {
    attendance = UserInfor(userID: data['userID'], username: data['username']);
    timestamp = (data['timestamp'] as Timestamp).toDate();
    content = data['content'];
    title = data['title'];
    comments = (data['comments'] as List ?? []).map((c) {
      return Comment.fromMap(c);
    }).toList();
  }
}
