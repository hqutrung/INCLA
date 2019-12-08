import 'package:flutter/material.dart';

class showTaiLieu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              onPressed: (){},
              padding: EdgeInsets.all(10),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: <Widget>[
                   Column(
                    children: <Widget>[
                      Icon(
                        Icons.insert_drive_file,
                        size: 65,
                      ),
                    ],
                  ),
                   Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Lý thuyến OOP',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'oop.doc',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          'SE102.K12 - Lập trình hướng Đối tượng',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          'Ngày tạo: 20/10/2019',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ]),
                ],
              ),
            )

          );
        });
  }
}