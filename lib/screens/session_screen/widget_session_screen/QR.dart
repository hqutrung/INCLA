import 'package:flutter/material.dart';

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
    return GestureDetector(
      onTap: () {
        showCreateQRDialog(context);
      },
      child: Container(
        child: Icon(
          Icons.center_focus_weak,
          size: 250,
        ),
      ),
    );
  }
}
