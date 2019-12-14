import 'package:document/models/course.dart';
import 'package:document/models/post.dart';
import 'package:document/models/user.dart';
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

  showEditCommentDialog(BuildContext context, Course course, String content,
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
              FlatButton(
                  child: const Text('Sửa'),
                  onPressed: () {

                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Course course = Provider.of<Course>(context, listen: false);
    User user = Provider.of<User>(context, listen: false);
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo-uit.png'),
            backgroundColor: Colors.white,
            radius: 25.0,
          ),
          title: Text(
            widget.post.attendance.username,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(widget.post.timestamp.toString()),
          trailing: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: widget.moveBack,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Text(
              widget.post.content,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Divider(
          height: 10.0,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.post.comments.length,
            itemBuilder: (context, index) => Slidable(
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage:
                        const AssetImage('assets/images/logo-uit.png'),
                    radius: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.comments[index].attendance.username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8),
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: Text(widget.post.comments[index].content),
                      ),
                    ],
                  ),
                ],
              ),
              actionPane: SlidableDrawerActionPane(),
              actions: <Widget>[
                IconSlideAction(
                    color: Colors.red,
                    icon: Icons.delete_outline,
                    onTap: () {}),
                IconSlideAction(
                    color: Colors.green, icon: Icons.edit, onTap: () {
                      showEditCommentDialog(context, course, widget.post.comments[index].content);
                    }),
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
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  FireStoreHelper().createComment(course, widget.post.uid, user,
                      _commentTextcontroller.text);
                  FocusScope.of(context).requestFocus(new FocusNode());
                  _commentTextcontroller.clear();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
