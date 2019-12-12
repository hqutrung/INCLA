import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document/models/user_infor.dart';
import 'package:document/models/course.dart';
import 'package:document/models/post.dart';
import 'package:document/models/session.dart';
import 'package:document/models/user.dart';
import 'package:flutter/material.dart';

class FireStoreHelper {
  static const String C_COURSE = 'course';
  static const String C_USER_COURSE = 'user_course';
  static const String C_POST = 'post';
  static const String C_SESSION = 'session';
  static const String C_ATTENDANCE = 'attendance';

  Firestore _db = Firestore.instance;

  static final Map models = {
    User: (Map data, String email) => User.fromMap(data, email: email),
    Session: (Map data, String uid) => Session.fromMap(data, id: uid),
  };

  Future<List<Course>> getCourses(String userID) async {
    QuerySnapshot snapshots = await _db
        .collection(C_USER_COURSE)
        .where('userID', isEqualTo: userID)
        .getDocuments();
    return snapshots.documents.map((data) {
      return Course.fromMap(data.data,
          reference: _db.collection(C_COURSE).document(data.data['courseID']));
    }).toList();
  }

  Future<List<UserInfor>> getStudents(String courseID) async {
    QuerySnapshot snapshots = await _db
        .collection(C_USER_COURSE)
        .where('courseID', isEqualTo: courseID)
        .getDocuments();
    return snapshots.documents.map((data) {
      return UserInfor.fromMap(data.data);
    }).toList();
  }

  Future<List<Post>> getPosts(String courseID, String sessionID) async {
    QuerySnapshot snapshots = await _db
        .collection(C_COURSE)
        .document(courseID)
        .collection(C_POST)
        .where('sessionID', isEqualTo: sessionID)
        .getDocuments();
    return snapshots.documents.map((data) {
      return Post.fromMap(data.data, uid: data.documentID);
    }).toList();
  }

  Stream<List<Post>> getPostsStream(String courseID, String sessionID) {
    print(courseID + ' ' + sessionID);
    return _db
        .collection(C_COURSE)
        .document(courseID)
        .collection(C_POST)
        .where('sessionID', isEqualTo: sessionID)
        .snapshots()
        .map(
          (query) => query.documents
              .map(
                (snapshot) =>
                    Post.fromMap(snapshot.data, uid: snapshot.documentID),
              )
              .toList(),
        );
  }

  Future createSession(Course course, String topic) async {
    try {
      await _db
          .collection(C_COURSE)
          .document(course.courseID)
          .collection(C_SESSION)
          .add({
        'start': Timestamp.fromDate(DateTime.now()),
        'end': Timestamp.fromDate(DateTime.now().add(Duration(hours: 2))),
        'topic': topic,
      });
    } catch (e) {
      print('create session: ' + e.toString());
    }
  }

  Future deleteSession(Course course, String id) async {
    try {
      _db
          .collection(C_COURSE)
          .document(course.courseID)
          .collection(C_SESSION)
          .document(id)
          .delete();
    } catch (e) {
      print('delete session: ' + e.toString());
    }
  }

  void createTopic(String sessionID, Course course, User user,
      {@required String title, @required String content}) {
    try {
      _db
          .collection(C_COURSE)
          .document(course.courseID)
          .collection(C_POST)
          .add({
        'content': content,
        'timestamp': Timestamp.fromDate(DateTime.now()),
        'title': title,
        'userID': user.uid,
        'username': user.name,
        'read': false,
        'sessionID': sessionID,
      });
    } catch (e) {
      print('Create topic: ' + e.toString());
    }
  }

  Future createComment(
      Course course, String postID, User user, String content) async {
    try {
      Map<String, dynamic> x = {
        'content': content,
        'timestamp': Timestamp.fromDate(DateTime.now()),
        'userID': user.uid,
        'username': user.name,
      };
      return await course.reference
          .collection(C_POST)
          .document(postID)
          .setData({
        'comments': FieldValue.arrayUnion([x])
      }, merge: true);
    } catch (e) {
      print('create comment error: ' + e.toString());
    }
  }

  Stream<Post> getDetailPostStream(
    Course course,
    String postID,
  ) {
    return course.reference.collection(C_POST).document(postID).snapshots().map(
        (snapshot) => Post.fromMap(snapshot.data, uid: snapshot.documentID));
  }

  Future<String> createAttendance(
      {@required Course course, int duration, @required String sessionID}) async {
        print('create attendance called');
    try {
      await _db
          .collection(C_COURSE)
          .document(course.courseID)
          .collection(C_ATTENDANCE)
          .add({
        'duration': duration,
        'sessionID': sessionID,
        'offline': await course.getAllMembersArray(),
      });
    } catch (e) {
      print('create attendance: ' + e.toString());
    }
  }

  // Stream<List<Session>>
}
