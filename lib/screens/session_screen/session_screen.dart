import 'package:document/screens/shared_widgets/home_drawer.dart';
import 'package:flutter/material.dart';

class SessionScreen extends StatefulWidget {
  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Tuần 1 - Ngày 10/10/2019'),
      ),
    );
  }
}