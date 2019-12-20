import 'package:document/models/course.dart';
import 'package:document/models/post.dart';
import 'package:document/models/user.dart';
import 'package:document/screens/shared_widgets/confirm_dialog.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class DetailTopic extends StatefulWidget {
  final Post post;
  final Function moveBack;

  DetailTopic({@required this.post, @required this.moveBack});

  @override
  _DetailTopicState createState() => _DetailTopicState();
}

class _DetailTopicState extends State<DetailTopic> {
  TextEditingController _commentTextcontroller = TextEditingController();

  showEditCommentDialog(
    BuildContext context,
    Course course,
    String content,
  ) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          TextEditingController _textEditingController =
              TextEditingController(text: content);
          return AlertDialog(
            content: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Chỉnh sửa',
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
              FlatButton(child: const Text('Sửa'), onPressed: () {})
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Course course = Provider.of<Course>(context, listen: false);
    User user = Provider.of<User>(context, listen: false);
    return Scaffold(
      body: Column(children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: widget.post.comments.length + 1,
            itemBuilder: (context, index) => (index == 0)
                ? Column(
                    children: <Widget>[
                      ListTile(
                        leading:IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: widget.moveBack,
                        ), 
                        title: Text(
                          widget.post.attendance.username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(widget.post.timestamp.toString()),
                        trailing: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/logo-uit.png'),
                          backgroundColor: Colors.white,
                          radius: 25.0,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
                          child: Text(
                            widget.post.content,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Divider(
                        height: 10.0,
                      ),
                    ],
                  )
                : Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Slidable(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: const AssetImage(
                                  'assets/images/logo-uit.png'),
                              radius: 25,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.post.comments[index - 1].attendance
                                      .username,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.8),
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25),
                                    ),
                                  ),
                                  child: Text(
                                      widget.post.comments[index - 1].content),
                                ),
                              ],
                            ),
                          ],
                        ),
                        actionPane: SlidableDrawerActionPane(),
                        actions: (user.type == UserType.Teacher ||
                                user.uid ==
                                    widget.post.comments[index - 1].attendance
                                        .userID)
                            ? <Widget>[
                                IconSlideAction(
                                    color: Colors.red,
                                    icon: Icons.delete_outline,
                                    onTap: () {
                                      confirmDialog(
                                          context, 'Xác nhận xóa topic?', () {
                                        //Firebase xóa
                                      });
                                    }),
                                IconSlideAction(
                                    color: Colors.green,
                                    icon: Icons.edit,
                                    onTap: () {
                                      showEditCommentDialog(
                                          context,
                                          course,
                                          widget.post.comments[index - 1]
                                              .content);
                                    }),
                              ]
                            : null,
                      ),
                    ),
                  ),
          ),
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        child: TextFormField(
          controller: _commentTextcontroller,
          decoration: InputDecoration(
            hintText: 'Trả lời',
            filled: true,
            prefixIcon: Icon(
              Icons.comment,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                FireStoreHelper().createComment(
                    course, widget.post.uid, user, _commentTextcontroller.text);
                FocusScope.of(context).requestFocus(new FocusNode());
                _commentTextcontroller.clear();
              },
            ),
          ),
        ),
      ),
    );
  }
}
