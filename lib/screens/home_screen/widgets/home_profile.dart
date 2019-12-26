import 'package:document/models/user.dart';
import 'package:document/utils/ConvertDateTime.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key key,
  }) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: Image(
                    image: AssetImage('assets/images/anh-bia.png'),
                  ),
                ),
                Contact(
                  user: user,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/images/logo-uit.png'),
                    // backgroundImage: AssetImage('assets/images/logo-uit.png'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Contact extends StatelessWidget {
  final User user;

  Contact({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.account_box),
                SizedBox(
                  width: 50,
                ),
                Text(user.name),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.call),
                SizedBox(
                  width: 50,
                ),
                Text(user.phoneNumber),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.mail),
                SizedBox(
                  width: 50,
                ),
                Text(user.email),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.calendar_today),
                SizedBox(
                  width: 50,
                ),
                Text(ConvertDateTimeToBirthday(user.birthday.toDate())),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.supervised_user_circle),
                SizedBox(
                  width: 50,
                ),
                Text((user.type == UserType.Student)
                    ? 'Sinh viên'
                    : 'Giảng viên'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
