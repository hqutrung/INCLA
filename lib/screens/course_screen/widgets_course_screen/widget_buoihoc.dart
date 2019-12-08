import 'package:document/screens/session_screen/session_screen.dart';
import 'package:flutter/material.dart';


class showBuoiHoc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(1),
          child: RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SessionScreen()));
            },
            padding: EdgeInsets.all(5),
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Tuần $index - Ngày 22/11/2019')
              ],
            ),
          ),
        );
      },
    );
  }
}
