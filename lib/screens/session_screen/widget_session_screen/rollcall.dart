import 'package:document/screens/session_screen/widget_session_screen/QR.dart';
import 'package:document/screens/session_screen/widget_session_screen/listRollcall.dart';
import 'package:flutter/material.dart';

class RollCall extends StatefulWidget {
  final String sessionID;
  RollCall({@required this.sessionID});
  @override
  _RollCallState createState() => _RollCallState();
}

class _RollCallState extends State<RollCall> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: GestureDetector(
      child: SingleChildScrollView(
        child: Container(
          height: height,
          child: Column(
            children: <Widget>[
              QRSection(sessionID: widget.sessionID),
              showListRollCall(),
            ],
          ),
        ),
      ),
    ));
  }
}
