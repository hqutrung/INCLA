import 'package:document/screens/login_screen/widgets/login_logo.dart';
import 'package:document/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService _auth = AuthService();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Future login(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));

    await _auth.signInWithEmail(emailController.text, passwordController.text);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              LoginLogo(),
              TextField(
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
                
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () => login(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
