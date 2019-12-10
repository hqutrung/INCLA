import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text('Topic'),
          icon: Icon(Icons.add),
        ),
        body: ListView.builder(
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
        ),
      );
    } else if (isTopicDetail) {
      return Column(
        children: <Widget>[
          ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo-uit.png'),
                backgroundColor: Colors.white,
                radius: 25.0,
              ),
              title: Text(
                'Huỳnh Quốc Trung',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('21/10/2019 3:32'),
              trailing: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    isTopicDetail = !isTopicDetail;
                    print(isTopicDetail);
                  });
                },
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
                'Chương trình đào tạo hướng đến đào tạo nguồn nhân lực công nghệ thông tin chất lượng cao đạt trình độ khu vực và quốc tế, đáp ứng nhu cầu xây dựng nguồn nhân lực ngành công nghiệp công nghệ thông tin trong cả nước.Sinh viên tốt nghiệp chương trình Kỹ sư ngành Kỹ thuật phần mềm phải đáp ứng các yêu cầu:\n- Có kiến thức cơ bản vững vàng, trình độ chuyên môn giỏi, kỹ năng phát triển phần mềm chuyên nghiệp, có năng lực nghiên cứu và tư duy sáng tạo.'),
          ),
          Divider(
            height: 10.0,
          ),
          
        ],
      );
    }
  }
}
