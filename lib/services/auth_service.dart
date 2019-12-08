import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document/models/student.dart';
import 'package:document/models/teacher.dart';
import 'package:document/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<User> get getUser async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    if (firebaseUser == null) return null;
    DocumentReference docRef =
        _db.collection(User.COLLECTION_PATH).document(firebaseUser.email);
    DocumentSnapshot snapshot = await docRef.get();
    Map data = snapshot.data;
    if (data['user_type'] == 0)
      return Teacher.fromMap(snapshot.data, firebaseUser.email, docRef);
    else
      return Student.fromMap(snapshot.data, firebaseUser.email, docRef);
  }

  Stream<User> get getUserStream {
    return FirebaseAuth.instance.onAuthStateChanged.asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;
      DocumentReference docRef =
          _db.collection(User.COLLECTION_PATH).document(firebaseUser.email);
      DocumentSnapshot snapshot = await docRef.get();
      Map data = snapshot.data;
      if (data['user_type'] == 0)
        return Teacher.fromMap(snapshot.data, firebaseUser.email, docRef);
      else
        return Student.fromMap(snapshot.data, firebaseUser.email, docRef);
    });
  }

  Future<User> signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user == null)
        return null;
      else {
        DocumentReference docRef =
            _db.collection(User.COLLECTION_PATH).document(result.user.email);
        DocumentSnapshot snapshot = await docRef.get();
        Map data = snapshot.data;
        if (data['user_type'] == 0)
          return Teacher.fromMap(snapshot.data, email, docRef);
        else
          return Student.fromMap(snapshot.data, email, docRef);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  bool hasUser() {
    return _auth.currentUser() != null;
  }

  Future signOut() {
    return _auth.signOut();
  }
}
