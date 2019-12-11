import 'package:document/models/course.dart';
import 'package:document/models/post.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';

class showTopic extends StatefulWidget {
  final Course course;
  final String sessionID;

  showTopic({@required this.course, @required this.sessionID});

  @override
  _showTopicState createState() => _showTopicState();
}

class _showTopicState extends State<showTopic> {
  bool isTopicDetail = false;

  Future<List<Post>> postsAsyncer;

  showAddTopicDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          var _titleEditingController = TextEditingController(),_contentEditingController = TextEditingController();
          return AlertDialog(
            content: Column(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  controller: _titleEditingController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Tiêu đề',
                  ),
                )),
                Expanded(
                    child: TextField(
                  controller: _contentEditingController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Nội dung',
                  ),
                ))
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              FlatButton(
                  child: const Text('Lưu'),
                  onPressed: () {
                    // addTodo(_textEditingController.text.toString());
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  @override
  void initState() {
    postsAsyncer =
        FireStoreHelper().getPosts(widget.course.courseID, widget.sessionID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isTopicDetail) {
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showAddTopicDialog(context);
          },
          label: Text('Topic'),
          icon: Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: postsAsyncer,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Text('Loading...');
            else {
              List<Post> posts = snapshot.data;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) => Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/logo-uit.png'),
                    ),
                    title: Text(posts[index].title),
                    subtitle: Text(
                        'Người tạo: ${posts[index].attendance.username}. \n${posts[index].timestamp} - ${posts[index].comments.length} Trả lời'),
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
                      });
                    },
                  ),
                ),
              );
            }
          },
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
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/logo-uit.png'),
                  ),
                  title: Text(
                    'Huỳnh Quốc Trung',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('anbczcjsd'),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
