import 'dart:async';

import 'package:document/src/firebase/firebase_auth.dart';
import 'package:document/src/validators/validation.dart';

class SignupBloc {
  StreamController _email = new StreamController();
  StreamController _pass = new StreamController();
  StreamController _repass = new StreamController();

  FireAuth _auth = new FireAuth();

  Stream get emailStream => _email.stream;

  Stream get repassStream => _repass.stream;

  bool isValidInfo(String email, String pass, String repass) {
    if (!Validations.isEmail(email)) {
      _email.sink.addError('Email không hợp lệ!');
      return false;
    }
    if (!Validations.isRepass(pass, repass)) {
      _repass.sink.addError('Mật khẩu không trùng khớp!');
      return false;
    }
    if (!Validations.isPass(pass)) {
      _pass.sink.addError('Mật khẩu không hợp lệ!');
      return false;
    }
    return true;
  }

  void signUp(String email, String pass, Function onSuccess) =>
      _auth.signup(email, pass, onSuccess);

  void dispose() {
    _pass.close();
    _repass.close();
    _email.close();
  }
}
