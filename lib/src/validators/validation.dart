class Validations {
  static bool isRepass(String pass, String repass) {
    return pass != null && pass == repass;
  }

  static bool isEmail(String email) {
    return email != null && email.contains('@') && email.contains('.');
  }

  static bool isPass(String pass) {
    return pass != null;
  }
}
