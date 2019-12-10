
import 'package:flutter/material.dart';

class showTopic extends StatefulWidget {
  @override
  _showTopicState createState() => _showTopicState();
}

class _showTopicState extends State<showTopic> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isTopicDetail = false;
  @override
  Widget build(BuildContext context) {
    if (!isTopicDetail) {
      print('zgxzbc');
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) => Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/logo-uit.png'),
            ),
            title: Text('Thắc mắc bài giảng'),
            subtitle: Text(
                'Người tạo: Huỳnh Quốc Trung. \n21/10/2019 3:32    4 Trả lời'),
            trailing: IconButton(
              icon: Icon(
                Icons.bookmark,
                color: Colors.orange,
              ),
              onPressed: () {
                setState(() {});
              },
            ),
            onTap: () {
              setState(() {
                isTopicDetail = !isTopicDetail;
                print(isTopicDetail);
              });
            },
          ),
        ),
      );
    } else if (isTopicDetail) {
      print('abc');
      return Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo-uit.png'),
              backgroundColor: Colors.white,
              radius: 25.0,
            ),
          ),
        ],
      );
    }
  }
}
