import 'package:flutter/material.dart';

class showTopic extends StatefulWidget {
  @override
  _showTopicState createState() => _showTopicState();
}

class _showTopicState extends State<showTopic> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.bookmark,color: Colors.orange,),
            onPressed: () {
              setState(() {
                
              });
            },
          ),
          onTap: () {
            //Navigator.push(context,MaterialPageRoute(builder: (context) => CourseScreen()));
          },
        ),
      ),
    );
  }
}
