import 'package:barcode_scan/barcode_scan.dart';
import 'package:document/models/attendance.dart';
import 'package:document/models/course.dart';
import 'package:document/models/user.dart';
import 'package:document/screens/session_screen/widget_session_screen/QR.dart';
import 'package:document/screens/session_screen/widget_session_screen/listRollcall.dart';
import 'package:document/screens/shared_widgets/confirm_dialog.dart';
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
  User user;

  @override
  void initState() {
    course = Provider.of<Course>(context, listen: false);
    user = Provider.of<User>(context, listen: false);
    attendanceStream = FireStoreHelper()
        .getAttendanceStream(course: course, sessionID: widget.sessionID);
    super.initState();
  }

  void _showCreateQRDialog(BuildContext context, Course course) {
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
                      course: course, duration: i, sessionID: widget.sessionID);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future<String> getApplyQRCode() async {
    return await BarcodeScanner.scan();
  }

  Future _applyQRCode(Attendance attendance) async {
    if (attendance.timestamp.add(Duration(minutes: attendance.duration)).isBefore(DateTime.now())) {
      toastDialog(context, "Đã hết thời gian điểm danh", () {});
    }

    String code = await getApplyQRCode();
    String ok = FireStoreHelper().presentAttendance(
        course: course, sessionID: widget.sessionID, code: code, user: user);
    if (ok != null) confirmDialog(context, ok, () {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return StreamBuilder<Attendance>(
      stream: attendanceStream,
      builder: (context, snapshot) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: height,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: (snapshot.data == null)
                    ? [
                        QRSection(
                          qrInteraction: () => user.type == UserType.Teacher
                              ? _showCreateQRDialog(context, course)
                              : () {},
                          attendance: snapshot.data,
                        )
                      ]
                    : [
                        QRSection(
                          attendance: snapshot.data,
                          qrInteraction: user.type == UserType.Student
                              ? () => _applyQRCode(snapshot.data)
                              : () {},
                        ),
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
