import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:incla/models/student.dart';
import 'package:incla/models/teacher.dart';
import 'package:incla/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<User> emailLogin(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    if (result.user == null)
      return null;
    else {
      DocumentReference docRef = _db.collection(User.COLLECTION_PATH).document(result.user.email);
      DocumentSnapshot snapshot = await docRef.get();
      Map data = snapshot.data;
      if (data['user_type'] == 0) 
        return Teacher.fromMap(snapshot.data, email, docRef);
      else
        return Student.fromMap(snapshot.data, email, docRef);
    }
  }

  Future signOut() {
    return _auth.signOut();
  }
}