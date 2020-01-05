import 'package:document/models/course.dart';
import 'package:document/models/post.dart';
import 'package:document/models/user.dart';
import 'package:document/screens/shared_widgets/confirm_dialog.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:document/utils/ConvertDateTime.dart';
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

  @override
  Widget build(BuildContext context) {
    Course course = Provider.of<Course>(context, listen: false);
    User user = Provider.of<User>(context, listen: false);
    final SlidableController slidableController = SlidableController();
    return Scaffold(
      body: Column(children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: widget.post.comments.length + 1,
            itemBuilder: (context, index) => (index == 0)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: widget.moveBack,
                        ),
                        title: Text(
                          widget.post.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.post.attendance.username),
                            Text(ConvertDateTime(widget.post.timestamp)),
                          ],
                        ),
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
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Divider(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.comment),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.post.comments.length.toString() +
                                ' bình luận',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Divider(
                        height: 10.0,
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Slidable(
                      closeOnScroll: true,
                      actionExtentRatio: 0.13,
                      key: Key(widget.post.comments[index - 1].toString()),
                      controller: slidableController,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                widget.post.comments[index - 1].attendance
                                    .username,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ConvertDateTime(
                                    widget.post.comments[index - 1].timestamp),
                                style: TextStyle(fontSize: 11),
                              ),
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.7),
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
                                  icon: Icons.delete_outline,
                                  onTap: () {
                                    confirmDialog(
                                        context, 'Xác nhận xóa bình luận?', () {
                                      print('xoa');
                                      FireStoreHelper().deleteComment(
                                          course,
                                          widget.post.uid,
                                          widget.post.comments[index - 1]);
                                    });
                                  }),
                            ]
                          : null,
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
