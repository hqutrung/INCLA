import 'package:document/models/course.dart';
import 'package:document/models/post.dart';
import 'package:document/models/user.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailTopic extends StatelessWidget {
  final Post post;
  final Function moveBack;
  final Course course;

  DetailTopic({@required this.post, @required this.moveBack, @required this.course});

  @override
  Widget build(BuildContext context) {
    TextEditingController _commentTextcontroller = TextEditingController();
    User user = Provider.of<User>(context);
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo-uit.png'),
            backgroundColor: Colors.white,
            radius: 25.0,
          ),
          title: Text(
            post.attendance.username,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(post.timestamp.toString()),
          trailing: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: moveBack,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Text(
              post.content,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Divider(
          height: 10.0,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: post.comments.length,
            itemBuilder: (context, index) => Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: const AssetImage('assets/images/logo-uit.png'),
                  radius: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.comments[index].attendance.username,
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
                      child: Text(post.comments[index].content),
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
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  FireStoreHelper().createComment(course,
                      post.uid, user, _commentTextcontroller.text);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
