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

  Future<List<Post>> getPosts(
      String courseID, String sessionID) async {
    QuerySnapshot snapshots = await _db
        .collection('course').document(courseID).collection('post')
        .where('sessionID', isEqualTo: sessionID)
        .getDocuments();
    return snapshots.documents.map((data) {
      return Post.fromMap(data.data);
    }).toList();
  }
  // Stream<List<Session>>
}
