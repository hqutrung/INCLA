import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document/models/attendance.dart';
import 'package:document/models/course.dart';
import 'package:document/models/notification.dart';
import 'package:document/models/post.dart';
import 'package:document/models/rate.dart';
import 'package:document/models/resource.dart';
import 'package:document/models/session.dart';
import 'package:document/models/test.dart';
import 'package:document/models/user.dart';
import 'package:document/models/user_infor.dart';
import 'package:flutter/material.dart';

class FireStoreHelper {
  static const String C_COURSE = 'course';
  static const String C_USER_COURSE = 'user_course';
  static const String C_POST = 'post';
  static const String C_TEST = 'test';
  static const String C_SESSION = 'session';
  static const String C_ATTENDANCE = 'attendance';
  static const String C_RATE = 'rate';
  static const String C_RESOURCE = 'resource';
  static const String C_NOTIFICATION = 'notification';
  static const String C_NOTIS = 'notis';

  Firestore _db = Firestore.instance;

  static final Map models = {
    User: (Map data, String email) => User.fromMap(data, email: email),
    Session: (Map data, String uid) => Session.fromMap(data, id: uid),
    Resource: (Map data, String uid) => Resource.fromMap(data, uid: uid),
    Noti: (Map data, String uid) => Noti.fromMap(data, id: uid),
    Rates: (Map data) => Rates.fromMap(data),
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

  Future<Course> getCoursefromID(String courseID) {}

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

  Stream<List<Test>> getTestsStream(String courseID, String sessionID) {
    print(courseID + ' ' + sessionID);
    return _db
        .collection(C_COURSE)
        .document(courseID)
        .collection(C_TEST)
        .where('sessionID', isEqualTo: sessionID)
        .snapshots()
        .map(
          (query) => query.documents
              .map(
                (snapshot) =>
                    Test.fromMap(snapshot.data, uid: snapshot.documentID),
              )
              .toList(),
        );
  }

  Future createSession(Course course, String topic, User user) async {
    try {
      var x = await _db
          .collection(C_COURSE)
          .document(course.courseID)
          .collection(C_SESSION)
          .add({
        'start': Timestamp.fromDate(DateTime.now()),
        'topic': topic,
      });
      pushNotiAllUser(
          creator: user,
          courseID: course.courseID,
          content: 'đã bắt đầu buổi mới trong lớp',
          title: 'Bắt đầu buổi học',
          type: 2,
          sessionID: x.documentID);
    } catch (e) {
      print('create session: ' + e.toString());
    }
  }

  Future endSession(Course course, String sessionID) async {
    try {
      await _db
          .collection(C_COURSE)
          .document(course.courseID)
          .collection(C_SESSION)
          .document(sessionID)
          .setData({
        'end': Timestamp.fromDate(DateTime.now()),
      }, merge: true);
    } catch (e) {
      print('end session: ' + e.toString());
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
        'link': link,
      });
    } catch (e) {
      print('create resource ' + e.toString());
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

  Future updateResource(
      Course course, String name, String link, String resourceID) async {
    try {
      await _db
          .collection(C_COURSE)
          .document(course.courseID)
          .collection(C_RESOURCE)
          .document(resourceID)
          .updateData({
        'time': Timestamp.fromDate(DateTime.now()),
        'name': name,
        'link': link
      });
    } catch (e) {
      print('create session: ' + e.toString());
    }
  }

  Future deletePostOfSession(Course course, String sessionID) async {
    try {
      await course.reference
          .collection(C_POST)
          .where('sessionID', isEqualTo: sessionID)
          .getDocuments()
          .then((querySnapshot) {
        for (int i = 0; i < querySnapshot.documents.length; i++)
          querySnapshot.documents[i].reference.delete();
      });
    } catch (e) {
      print('delete post of session: ' + e.toString());
    }
  }

  Future deleteTestOfSession(Course course, String sessionID) async {
    try {
      await course.reference
          .collection(C_TEST)
          .where('sessionID', isEqualTo: sessionID)
          .getDocuments()
          .then((querySnapshot) {
        for (int i = 0; i < querySnapshot.documents.length; i++)
          querySnapshot.documents[i].reference.delete();
      });
    } catch (e) {
      print('delete test of session: ' + e.toString());
    }
  }

  Future deleteSession(Course course, String id) async {
    try {
      await course.reference.collection(C_SESSION).document(id).delete();
      await course.reference.collection(C_RATE).document(id).delete();
      await course.reference.collection(C_ATTENDANCE).document(id).delete();
      await deletePostOfSession(course, id);
      await deleteTestOfSession(course, id);
    } catch (e) {
      print("Delete session: " + e.toString());
    }
  }

  Future deleteResource(Course course, String resourceID) async {
    try {
      _db
          .collection(C_COURSE)
          .document(course.courseID)
          .collection(C_RESOURCE)
          .document(resourceID)
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
      pushNotiAllUser(
          creator: user,
          courseID: course.courseID,
          sessionID: sessionID,
          title: 'Thảo luận mới',
          content: 'đã tạo một thảo luận mới trong lớp',
          type: 1);
    } catch (e) {
      print('Create topic: ' + e.toString());
    }
  }

  Future pushNotiAllUser({
    User creator,
    String sessionID,
    String courseID,
    String title,
    String content,
    int type,
  }) async {
    List<UserInfor> listUserInfor = await getStudents(courseID);
    for (int i = 0; i < listUserInfor.length; i++) {
      addNotification(
        title: title,
        creator: creator,
        userID: listUserInfor[i].userID,
        courseID: courseID,
        sessionID: sessionID,
        content: content,
        type: type,
      );
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

  Future createResult(Course course, String testID, User user, int point,
      List<int> answers) async {
    try {
      Map<String, dynamic> x = {
        'point': point,
        'time': Timestamp.fromDate(DateTime.now()),
        'answers': answers,
        'userID': user.uid,
        'username': user.name,
      };
      return await course.reference
          .collection(C_TEST)
          .document(testID)
          .setData({
        'students': FieldValue.arrayUnion([x])
      }, merge: true);
    } catch (e) {
      print('create result error: ' + e.toString());
    }
  }

  Stream<Post> getDetailPostStream(
    Course course,
    String postID,
  ) {
    return course.reference.collection(C_POST).document(postID).snapshots().map(
        (snapshot) => Post.fromMap(snapshot.data, uid: snapshot.documentID));
  }

  Stream<Test> getDetailTestStream(
    Course course,
    String testID,
  ) {
    return course.reference.collection(C_TEST).document(testID).snapshots().map(
        (snapshot) => Test.fromMap(snapshot.data, uid: snapshot.documentID));
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
          .document(sessionID)
          .setData({
        'duration': duration,
        'offline': await course.getAllMembersArray(),
        'timestamp': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      print('create attendance: ' + e.toString());
    }
  }

  Future<Attendance> getAttendance(
      {@required Course course, @required String sessionID}) async {
    DocumentSnapshot snapshot = await course.reference
        .collection(C_ATTENDANCE)
        .document(sessionID)
        .get();
    return (snapshot == null)
        ? null
        : Attendance.fromMap(snapshot.data, reference: snapshot.reference);
  }

  Stream<Attendance> getAttendanceStream(
      {@required Course course, @required String sessionID}) {
    return course.reference
        .collection(C_ATTENDANCE)
        .document(sessionID)
        .snapshots()
        .map((DocumentSnapshot snapshot) =>
            Attendance.fromMap(snapshot.data, reference: snapshot.reference));
  }

  String presentAttendance(
      {@required Course course,
      @required String sessionID,
      @required String code,
      @required User user}) {
    if (sessionID != code) return 'Sai mã QR';
    DocumentReference attendance =
        course.reference.collection(C_ATTENDANCE).document(code);
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
    return null;
  }

  Stream<Rates> getRatesStream(
      {@required Course course, @required String sessionID}) {
    var x = course.reference
        .collection(C_RATE)
        .document(sessionID)
        .snapshots()
        .map((DocumentSnapshot query) => Rates.fromMap(query.data));

    return x;
  }

  Future rateSession(
      {@required Course course,
      @required Session session,
      @required User user,
      @required String content,
      @required int value}) async {
    try {
      course.reference.collection(C_RATE).document(session.id).setData({
        'rates': FieldValue.arrayUnion([
          {
            'value': value,
            'content': content,
            'userID': user.uid,
            'username': user.name,
          }
        ]),
        'timestamp': Timestamp.fromDate(session.startTime),
      }, merge: true);
    } catch (e) {
      print('rate session: ' + e.toString());
    }
  }

  Stream<List<Noti>> getNotification({@required userID}) {
    return _db
        .collection(C_NOTIFICATION)
        .document(userID)
        .collection(C_NOTIS)
        .snapshots()
        .map(
          (query) => query.documents
              .map(
                (snapshot) =>
                    Noti.fromMap(snapshot.data, id: snapshot.documentID),
              )
              .toList(),
        );
  }

  Future addNotification({
    @required User creator,
    @required String userID,
    @required String courseID,
    @required String sessionID,
    @required String title,
    @required String content,
    @required int type,
  }) async {
    try {
      await _db
          .collection(C_NOTIFICATION)
          .document(userID)
          .collection(C_NOTIS)
          .add({
        'title': title,
        'creatorID': creator.uid,
        'creatorName': creator.name,
        'content': content,
        'courseID': courseID,
        'sessionID': sessionID,
        'typeNoti': type,
        'timestamp': Timestamp.fromDate(DateTime.now()),
        'isRead': false,
      });
    } catch (e) {
      print('create attendance: ' + e.toString());
    }
  }

  Future<List<Rates>> getAllRates({@required Course course}) async {
    List<Rates> allRates = List<Rates>();
    await course.reference.collection(C_RATE).getDocuments().then((snapshot) {
      for (int i = 0; i < snapshot.documents.length; i++) {
        allRates.add(Rates.fromMap(snapshot.documents[i].data));
      }
    });
    return allRates;
  }

  Future<List<Attendance>> getAllAttendance({@required Course course}) async {
    List<Attendance> allAttendances = List<Attendance>();
    await course.reference
        .collection(C_ATTENDANCE)
        .getDocuments()
        .then((snapshot) {
      for (int i = 0; i < snapshot.documents.length; i++) {
        allAttendances.add(Attendance.fromMap(
          snapshot.documents[i].data,
          reference: snapshot.documents[i].reference,
        ));
      }
    });
    return allAttendances;
  }

  Future updateIsReadNoti(String userID, Noti noti) async {
    await _db
        .collection(C_NOTIFICATION)
        .document(userID)
        .collection(C_NOTIS)
        .document(noti.id)
        .updateData({'isRead': noti.isRead});
  }

  Future deleteNoti(String userID, Noti noti) async {
    await _db
        .collection(C_NOTIFICATION)
        .document(userID)
        .collection(C_NOTIS)
        .document(noti.id)
        .delete();
  }

  Future deleteTopic(String courseID, String postID) async {
    await _db
        .collection(C_COURSE)
        .document(courseID)
        .collection(C_POST)
        .document(postID)
        .delete();
  }
}
