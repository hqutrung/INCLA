import 'package:document/models/test.dart';
import 'package:flutter/material.dart';

class DetailTest extends StatefulWidget {
  final Test test;
  final Function moveBack;

  DetailTest({@required this.test, @required this.moveBack});

  @override
  _DetailTestState createState() => _DetailTestState();
}

class _DetailTestState extends State<DetailTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Expanded(
          child: Text('Body')
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        child: Text('NavigationBar')
      ),
    );
  }
}
