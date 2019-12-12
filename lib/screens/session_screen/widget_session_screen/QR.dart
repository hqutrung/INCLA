import 'package:document/models/course.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateQR extends StatefulWidget {
  @override
  _CreateQRState createState() => _CreateQRState();
}

showCreateQRDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (context) {
        TextEditingController _textFieldController;
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
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

class _CreateQRState extends State<CreateQR> {
  @override
  Widget build(BuildContext context) {
    Course course = Provider.of<Course>(context);
    return GestureDetector(
      onTap: () {
        print('ontap');
        showCreateQRDialog(context);
        return FireStoreHelper().createAttendance(course: course, duration: 2);
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
