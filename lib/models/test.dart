import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document/models/question_test.dart';
import 'package:document/models/result.dart';
import 'package:flutter/material.dart';

class Test {
  String uid;

  String title;
  DateTime time;
  List<Question> questions;
  List<int> results;
  List<Result> students;

  Test.fromMap(Map data, {@required this.uid}) {
    time = (data['time'] as Timestamp).toDate();
    title = data['title'];
    questions = (data['questions'] as List ?? []).map((question) {
      return Question.fromMap(question);
    }).toList();
    results = (data['results'].cast<int>() as List ?? []).toList();
    students = (data['students'] as List ?? []).map((result) {
      return Result.fromMap(result);
    }).toList();
  }
}
