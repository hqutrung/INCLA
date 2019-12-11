import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document/models/attandance.dart';
import 'package:document/models/course.dart';
import 'package:document/models/post.dart';
import 'package:document/models/session.dart';
import 'package:document/models/user.dart';

class FireStoreHelper {
  Firestore _db = Firestore.instance;

  static final Map models = {
    User: (Map data, String email) => User.fromMap(data, email: email),
    Session: (Map data, String uid) => Session.fromMap(data, id: uid),
  };

  Future<List<Course>> getCourses(String userID) async {
    QuerySnapshot snapshots = await _db
        .collection('user_course')
        .where('userID', isEqualTo: userID)
        .getDocuments();
    return snapshots.documents.map((data) {
      return Course.fromMap(data.data);
    }).toList();
  }

  Future<List<Attendance>> getStudents(String courseID) async {
    QuerySnapshot snapshots = await _db
        .collection('user_course')
        .where('courseID', isEqualTo: courseID)
        .getDocuments();
    return snapshots.documents.map((data) {
      return Attendance.fromMap(data.data);
    }).toList();
  }

  Future<List<Post>> getPosts(String courseID, String sessionID) async {
    QuerySnapshot snapshots = await _db
        .collection('course')
        .document(courseID)
        .collection('post')
        .where('sessionID', isEqualTo: sessionID)
        .getDocuments();
    return snapshots.documents.map((data) {
      return Post.fromMap(data.data);
    }).toList();
  }

  Future createSession(Course course, String topic) async {
    try {
      await _db
          .collection('course')
          .document(course.courseID)
          .collection('session')
          .add({
        'start': Timestamp.fromDate(DateTime.now()),
        'end': Timestamp.fromDate(DateTime.now().add(Duration(hours: 2))),
        'topic': topic,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteSession(Course course, String id) async {
    try {
      _db.collection('course').document(course.courseID).collection('session').document(id).delete();
    } catch(e) {
      print(e.toString());
    }
  }

  
  // Stream<List<Session>>
}
