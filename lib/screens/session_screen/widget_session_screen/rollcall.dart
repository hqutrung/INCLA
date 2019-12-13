import 'package:document/models/attendance.dart';
import 'package:document/models/course.dart';
import 'package:document/screens/session_screen/widget_session_screen/QR.dart';
import 'package:document/screens/session_screen/widget_session_screen/listRollcall.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RollCall extends StatefulWidget {
  final String sessionID;
  RollCall({@required this.sessionID});
  @override
  _RollCallState createState() => _RollCallState();
}

class _RollCallState extends State<RollCall> {
  Stream<Attendance> attendanceStream;
  Course course;

  @override
  void initState() {
    course = Provider.of<Course>(context, listen: false);
    attendanceStream = FireStoreHelper()
        .getAttendanceStream(course: course, sessionID: widget.sessionID);
    super.initState();
  }

  void showCreateQRDialog(BuildContext context, Course course) {
    TextEditingController _textFieldController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Tạo QR code điểm danh'),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Nhập phút"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Hủy'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Bắt đầu'),
                onPressed: () {
                  int i;
                  i = int.tryParse(_textFieldController.text);
                  if (i != null)
                    FireStoreHelper().createAttendance(
                        course: course,
                        duration: i,
                        sessionID: widget.sessionID);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return StreamBuilder<Attendance>(
      stream: attendanceStream,
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: height,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: (snapshot.data == null)
                    ? [QRSection(createQR: () => showCreateQRDialog(context, course))]
                    : [
                        QRSection(code: widget.sessionID, createQR: () {}),
                        AttendanceList(attendance: snapshot.data),
                      ],
              ),
            ),
          ),
        );
      },
    );
  }
}
