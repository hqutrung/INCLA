
import 'package:flutter/material.dart';



class showSinhVien extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(1),
          child: RaisedButton(
            onPressed: () {
              
            },
            padding: EdgeInsets.all(5),
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/logo-uit.png'),
                      backgroundColor: Colors.white,
                    )
                  ],
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Huỳnh Quốc Trung',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Mssv : 17520184',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        );
      },
    );
  }
}
