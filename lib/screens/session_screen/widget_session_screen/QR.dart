import 'package:document/models/attendance.dart';
import 'package:document/models/course.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRSection extends StatefulWidget {
  final String sessionID;
  QRSection({this.sessionID});
  @override
  _QRSectionState createState() => _QRSectionState();
}

class _QRSectionState extends State<QRSection> {
  @override
  void initState() {
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
                  setState(() {});
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Course course = Provider.of<Course>(context);
    return FutureBuilder<Attendance>(
      future: FireStoreHelper().getAttendance(
        course: course,
        sessionID: widget.sessionID,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return GestureDetector(
              onTap: () => showCreateQRDialog(context, course),
              child: Container(
                height: 250,
                width: 250,
                child: Icon(Icons.center_focus_weak, size: 250.0),
              ),
            );
          } else
            return Container(
              height: 250,
              width: 250,
              child: QrImage(
                data: widget.sessionID,
                size: 250.0,
              ),
            );
        } else
          return Text('Loading... ' + snapshot.connectionState.toString());
      },
    );
  }
}
