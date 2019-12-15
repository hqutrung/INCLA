import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Resource {
  String uid;
  String name;
  String link;
  DateTime time;

  Resource.fromMap(Map data, {@required this.uid}) {
    time = (data['time'] as Timestamp).toDate();
    name = data['name'];
    link = data['link'];
  }
}