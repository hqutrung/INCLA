import 'package:document/screens/login_screen/widgets/login_logo.dart';
import 'package:document/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  AuthService _auth = AuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future login() async {
    // showDialog(
    //     context: context,
    //     builder: (context) => Center(child: CircularProgressIndicator()));

    await _auth.signInWithEmail(emailController.text, passwordController.text);

    // Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    print("LoginScreen rebuild: " + context.toString());
    return Scaffold(
      body: Container(
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
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text('Login'),
              onPressed: () => login(),
            ),
          ],
        ),
      ),
    );
  }
}
