import 'package:document/screens/home_page.dart';
import 'package:document/screens/loginScreen/widgets/login_logo.dart';
import 'package:document/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String LOGINSCREEN_PATH = '/';
  LoginScreen();

  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService _auth = AuthService();

  bool _isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _auth.getUser.then((user) {
      if (user != null)
        Navigator.pushReplacementNamed(context, HomePage.HOMESCREEN_PATH);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            LoginLogo(),
            TextField(
              obscureText: true,
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              controller: passwordController,
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              child: Text('Login'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  // Widget _showCircularProgress() {
  //   if (_isLoading) {
  //     return Center(child: CircularProgressIndicator());
  //   }
  //   return Container(
  //     height: 0.0,
  //     width: 0.0,
  //   );
  // }

  // Widget _showForm() {
  //   return new Container(
  //       padding: EdgeInsets.all(16.0),
  //       child: new Form(
  //         child: new ListView(
  //           shrinkWrap: true,
  //           children: <Widget>[
  //             LoginLogo(),
  //             showEmailInput(),
  //             showPasswordInput(),
  //             showPrimaryButton(),
  //             showSecondaryButton(),
  //             // showErrorMessage(),
  //           ],
  //         ),
  //       ));
  // }

  // Widget showEmailInput() {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
  //     child: new TextFormField(
  //       maxLines: 1,
  //       keyboardType: TextInputType.emailAddress,
  //       autofocus: false,
  //       decoration: new InputDecoration(
  //           hintText: 'Email',
  //           icon: new Icon(
  //             Icons.mail,
  //             color: Colors.grey,
  //           )),
  //       validator: (value) => value.isEmpty ? 'Chưa nhập Email' : null,
  //       onSaved: (value) => _email = value.trim(),
  //     ),
  //   );
  // }

  // Widget showPasswordInput() {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
  //     child: new TextFormField(
  //       maxLines: 1,
  //       obscureText: true,
  //       autofocus: false,
  //       decoration: new InputDecoration(
  //           hintText: 'Password',
  //           icon: new Icon(
  //             Icons.lock,
  //             color: Colors.grey,
  //           )),
  //       validator: (value) => value.isEmpty ? 'Chưa nhập password' : null,
  //       onSaved: (value) => _password = value.trim(),
  //     ),
  //   );
  // }

  // Widget showSecondaryButton() {
  //   return new FlatButton(
  //       child: new Text(
  //           _isLoginForm ? 'Tạp tài khoản' : 'Đăng nhập',
  //           style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
  //       onPressed: toggleFormMode);
  // }

//   Widget showPrimaryButton() {
//     return new Padding(
//         padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
//         child: SizedBox(
//           height: 40.0,
//           child: new RaisedButton(
//             elevation: 5.0,
//             shape: new RoundedRectangleBorder(
//                 borderRadius: new BorderRadius.circular(30.0)),
//             color: Colors.blue,
//             child: new Text(_isLoginForm ? 'Đăng nhập' : 'Tạo tài khoản',
//                 style: new TextStyle(fontSize: 20.0, color: Colors.white)),
//             onPressed: validateAndSubmit,
//           ),
//         ));
//   }
// }

// mixin initState {
}
