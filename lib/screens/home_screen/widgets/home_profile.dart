import 'package:document/models/user.dart';
import 'package:document/screens/shared_widgets/main_appbar.dart';
import 'package:document/screens/shared_widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  

  const Profile({Key key, }) : super(key: key);
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
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/images/logo-uit.png'),
                    // backgroundImage: AssetImage('assets/images/logo-uit.png'),
                  ),
                ),
                Text(
                  user.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Contact(
                  user: user,
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
                Icon(Icons.call),
                SizedBox(
                  width: 120,
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
                  width: 120,
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
                  width: 120,
                ),
                Text(user.birthday.toDate().toString()),
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
                  width: 120,
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
