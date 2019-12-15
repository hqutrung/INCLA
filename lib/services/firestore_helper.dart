import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document/models/attendance.dart';
import 'package:document/models/rate.dart';
import 'package:document/models/user_infor.dart';
import 'package:document/models/course.dart';
import 'package:document/models/post.dart';
import 'package:document/models/session.dart';
import 'package:document/models/resource.dart';
import 'package:document/models/user.dart';
import 'package:document/models/user_infor.dart';
import 'package:flutter/material.dart';

class FireStoreHelper {
  static const String C_COURSE = 'course';
  static const String C_USER_COURSE = 'user_course';
  static const String C_POST = 'post';
  static const String C_SESSION = 'session';
  static const String C_ATTENDANCE = 'attendance';
  static const String C_RATE = 'rate';
  static const String C_RESOURCE = 'resource';

  Firestore _db = Firestore.instance;

  static final Map models = {
    User: (Map data, String email) => User.fromMap(data, email: email),
    Session: (Map data, String uid) => Session.fromMap(data, id: uid),
    Resource: (Map data, String name) => Resource.fromMap(data, name: name),
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

  Future updateSession(Course course, String topic, String sessionID) async {
    try {
      await _db
          .collection(C_COURSE)
          .document(course.courseID)
          .collection(C_SESSION)
          .document(sessionID)
          .updateData({
        'topic': topic,
      });
    } catch (e) {
      print('create session: ' + e.toString());
    }
  }

  Future createResource(Course course, String name, String link) async {
    try {
      await _db
          .collection(C_COURSE)
          .document(course.courseID)
          .collection(C_RESOURCE)
          .add({
            'time': Timestamp.fromDate(DateTime.now()),
            'name': name,
            'link': link
          });
    } catch (e) {
      print('create resource ' + e.toString());
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

  Future deleteResource(Course course, String name) async {
    try {
      _db
          .collection(C_COURSE)
          .document(course.courseID)
          .collection(C_RESOURCE)
          .document(name)
          .delete();
    } catch (e) {
      print('delete resource: ' + e.toString());
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

  Future createAttendance(
      {@required Course course,
      int duration,
      @required String sessionID}) async {
    try {
      await _db
          .collection(C_COURSE)
          .document(course.courseID)
          .collection(C_ATTENDANCE)
          .add({
        'duration': duration,
        'sessionID': sessionID,
        'offline': await course.getAllMembersArray(),
        'timestamp': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      print('create attendance: ' + e.toString());
    }
  }

  Future<Attendance> getAttendance(
      {@required Course course, @required String sessionID}) async {
    QuerySnapshot querySnapshot = await course.reference
        .collection(C_ATTENDANCE)
        .where('sessionID', isEqualTo: sessionID)
        .getDocuments();
    if (querySnapshot.documents.length > 0)
      return Attendance.fromMap(querySnapshot.documents[0].data,
          reference: querySnapshot.documents[0].reference);
    else
      return null;
  }

  Stream<Attendance> getAttendanceStream(
      {@required Course course, @required String sessionID}) {
    return course.reference
        .collection(C_ATTENDANCE)
        .where('sessionID', isEqualTo: sessionID)
        .limit(1)
        .snapshots()
        .map((QuerySnapshot query) => Attendance.fromMap(
            query.documents[0].data,
            reference: query.documents[0].reference));
  }

  void presentAttendance(
      {@required Course course,
      @required String attendanceID,
      @required User user}) {
    DocumentReference attendance =
        course.reference.collection(C_ATTENDANCE).document(attendanceID);
    if (attendance != null) {
      attendance.setData({
        'offline': FieldValue.arrayRemove([
          {'userID': user.uid, 'username': user.name},
        ]),
        'online': FieldValue.arrayUnion([
          {'userID': user.uid, 'username': user.name}
        ]),
      }, merge: true);
    }
  }

  Stream<Rates> getRatesStream(
      {@required Course course, @required String sessionID}) {
    return course.reference
        .collection(C_RATE)
        .document(sessionID)
        .snapshots()
        .map((DocumentSnapshot query) => Rates.fromMap(query.data));
  }

  Future rateSession(
      {@required Course course,
      @required String sessionID,
      @required User user,
      @required String content,
      @required int value}) async {
    course.reference.collection(C_RATE).document(sessionID).setData({
      'rates': FieldValue.arrayUnion([{
        'userID': user.uid,
        'username': user.name,
        'value': value,
        'content': content
      }])
    });
  }
}
