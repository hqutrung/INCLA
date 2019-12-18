import 'package:flutter/material.dart';

confirmDialog(BuildContext context, String text, Function confirm) async {
  await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              Text(text),
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child: const Text('Hủy'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            FlatButton(
                child: const Text('Xác nhận'),
                onPressed: () {
                  confirm();
                  Navigator.pop(context);
                })
          ],
        );
      });
}
