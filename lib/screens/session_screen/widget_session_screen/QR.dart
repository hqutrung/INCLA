import 'package:document/models/course.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QRSection extends StatefulWidget {
  final String sessionID;
  QRSection({this.sessionID});
  @override
  _QRSectionState createState() => _QRSectionState();
}

class _QRSectionState extends State<QRSection> {

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
    Course course = Provider.of<Course>(context);
    return GestureDetector(
      onTap: () {
        print('ontap');
        showCreateQRDialog(context, course);
      },
      child: Container(
        height: 250,
        width: 250,
        child: Icon(
          Icons.center_focus_weak,
          size: 250.0,
        ),
      ),
    );
  }
}
