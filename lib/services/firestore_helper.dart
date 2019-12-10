import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document/models/course.dart';
import 'package:document/models/user.dart';

class FireStoreHelper {
  Firestore _db = Firestore.instance;

  static final Map models = {
    User: (Map data, String email) => User.fromMap(data, email: email),
    Course: (Map data) => Course.fromMap(data),
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
}
