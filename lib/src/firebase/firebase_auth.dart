import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FireAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

 void login(String email, String pass, Function onSuccess) {
    _auth.signInWithEmailAndPassword(email: email, password: pass).then((user){
      onSuccess();
    });
  }

  void signup(String email, String pass, Function onSuccess) {
    _auth.createUserWithEmailAndPassword(email: email, password: pass).then((user){
      onSuccess();

    });
  }
}
