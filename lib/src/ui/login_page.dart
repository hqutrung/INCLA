import 'package:document/src/blocs/login_bloc.dart';
import 'package:document/src/ui/buoihoc_page.dart';
import 'package:document/src/ui/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  LoginBloc loginBloc = new LoginBloc();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'lib/src/images/logo-uit.png',
                  height: 120,
                  width: 120,
                ),
              ],
            ),
            StreamBuilder(
              stream: loginBloc.emailStream,
              builder: (context, snapshot) => TextField(
                controller: _emailController,
                onTap: () {},
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                    errorText: snapshot.hasError ? snapshot.error : null,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: loginBloc.passStream,
              builder: (context, snapshot) => TextField(
                controller: _passController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.fingerprint),
                    errorText: snapshot.hasError ? snapshot.error : null,
                    hintText: 'Mật khẩu',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 100,
                  child: RaisedButton(
                    onPressed: () {
                      if (loginBloc.isValidInfo(
                          _emailController.text, _passController.text)) {
                        loginBloc.login(
                            _emailController.text, _passController.text, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BuoiHocPage()));
                        });
                      }
                      else showDialog(builder: (context)=> new Dialog(
                        child: Container(
                          color: Colors.white,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                    'Tài khoản hoặc mật khẩu không chính xác'
                                ),
                              )
                            ],
                          ),
                        ) ,
                      ));
                    },
                    child: Text('Đăng nhập'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                ButtonTheme(
                  minWidth: 100,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    child: Text('Đăng ký'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
