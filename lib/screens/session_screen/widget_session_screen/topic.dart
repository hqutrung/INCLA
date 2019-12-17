import 'package:document/models/course.dart';
import 'package:document/models/post.dart';
import 'package:document/models/user.dart';
import 'package:document/screens/session_screen/widget_session_screen/detail_topic.dart';
import 'package:document/screens/shared_widgets/confirm_dialog.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

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
  User user;

  bool isTopicDetail = false;

  Stream<List<Post>> postsAsyncer;
  Stream<Post> detailPostAsyncer;

  void moveBack() {
    setState(() {
      isTopicDetail = !isTopicDetail;
    });
  }

  showAddTopicDialog(BuildContext context, User user) async {
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
                    FireStoreHelper().createTopic(
                        widget.sessionID, widget.course, user,
                        title: _titleEditingController.text,
                        content: _contentEditingController.text);
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  @override
  void initState() {
    updatePostsAsyncer();
    super.initState();
  }

  void updatePostsAsyncer() {
    postsAsyncer = FireStoreHelper()
        .getPostsStream(widget.course.courseID, widget.sessionID);
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (!isTopicDetail) {
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showAddTopicDialog(context, user);
          },
          label: Text('Topic'),
          icon: Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: postsAsyncer,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Text('Loading... ' + snapshot.connectionState.toString());
            else {
              List<Post> posts = snapshot.data;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) => Card(
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage('assets/images/logo-uit.png'),
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
                          detailPostAsyncer = FireStoreHelper()
                              .getDetailPostStream(
                                  widget.course, selectedPost.uid);
                        });
                      },
                    ),
                    actions: (user.type == UserType.Teacher||user.uid == posts[index].attendance.userID) ? <Widget>[
                      IconSlideAction(
                        color: Colors.red,
                        icon: Icons.delete_outline,
                        onTap: (){
                          confirmDialog(context, 'Xác nhận xóa topic?', () {
                          //Firebase xóa
                        });
                        }
                      ),
                      IconSlideAction(
                        color: Colors.green,
                        icon: Icons.edit,
                        onTap: (){}
                      ),
                    ] : null,
                  ),
                ),
              );
            }
          },
        ),
      );
    } else if (isTopicDetail) {
      return StreamBuilder<Post>(
          stream: detailPostAsyncer,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return DetailTopic(
                moveBack: moveBack,
                post: selectedPost,
              );
            else
              return DetailTopic(
                moveBack: moveBack,
                post: snapshot.data,
              );
          });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
