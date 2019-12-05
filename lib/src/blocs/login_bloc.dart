import 'dart:async';

import 'package:document/src/firebase/firebase_auth.dart';
import 'package:document/src/validators/validation.dart';

class LoginBloc {
  StreamController _email = new StreamController();
  StreamController _pass = new StreamController();
  StreamController _user = new StreamController();

  Stream get emailStream => _email.stream;
  Stream get passStream => _pass.stream;

  FireAuth _auth = new FireAuth();

  bool isValidInfo(String email, String pass) {
    if (!Validations.isEmail(email)) {
      _email.sink.addError('Email không hợp lệ!');
      return false;
    }
    if (!Validations.isPass(pass)) {
      _pass.sink.addError('Mật khẩu không hợp lệ!');
      return false;
    }
    return true;
  }

  void login(String email, String pass, Function onSuccess)
  {
    _auth.login(email, pass, onSuccess);
  }
  void dispose() {
    _pass.close();
    _email.close();
    _user.close();
  }
}
