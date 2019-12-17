import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document/models/question_test.dart';
import 'package:flutter/material.dart';

class Test {
  String uid;

  String title;
  DateTime time;
  List<Question> questions;

  Test.fromMap(Map data, {@required this.uid}) {
    time = (data['time'] as Timestamp).toDate();
    title = data['title'];
    questions = (data['comments'] as List ?? []).map((question) {
      return Question.fromMap(question);
    }).toList();
  }
}
