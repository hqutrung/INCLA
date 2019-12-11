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

class _showTopicState extends State<showTopic>
    with AutomaticKeepAliveClientMixin {
  Post selectedPost;

  bool isTopicDetail = false;

  Future<List<Post>> postsAsyncer;

  showAddTopicDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          var _titleEditingController = TextEditingController(),
              _contentEditingController = TextEditingController();
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
                        selectedPost = posts[index];
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
      TextEditingController _commentTextcontroller =
          new TextEditingController();
      return Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo-uit.png'),
              backgroundColor: Colors.white,
              radius: 25.0,
            ),
            title: Text(
              selectedPost.attendance.username,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(selectedPost.timestamp.toString()),
            trailing: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  isTopicDetail = !isTopicDetail;
                });
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Text(
                selectedPost.content,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Divider(
            height: 10.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedPost.comments.length,
              itemBuilder: (context, index) => Row(
                children: [
                  SizedBox(width: 10,),
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage('assets/images/logo-uit.png'),
                          radius: 25,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedPost.attendance.username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width*0.8),
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: Text(selectedPost.comments[index].content),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: TextFormField(
              controller: _commentTextcontroller,
              decoration: InputDecoration(
                  hintText: 'Trả lời',
                  filled: true,
                  prefixIcon: Icon(
                    Icons.comment,
                  ),
                  suffixIcon:
                      IconButton(icon: Icon(Icons.send), onPressed: () {})),
            ),
          ),
        ],
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
