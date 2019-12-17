import 'package:document/models/notification.dart';
import 'package:document/models/user.dart';
import 'package:document/screens/session_screen/session_screen.dart';
import 'package:document/screens/shared_widgets/main_appbar.dart';
import 'package:document/screens/shared_widgets/main_drawer.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeNotification extends StatefulWidget {
  final MainDrawer drawer;

  const HomeNotification({Key key,@required this.drawer}) : super(key: key);
  @override
  _HomeNotificationState createState() => _HomeNotificationState();
}

class _HomeNotificationState extends State<HomeNotification> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Stream<List<Noti>> notiList;

  @override
  void initState() {
    User user = Provider.of<User>(context, listen: false);
    notiList = FireStoreHelper().getNotification(userID: user.uid);
    super.initState();
  }

  Widget _buildListNoti(List<Noti> notis) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: notis.length,
      itemBuilder: (BuildContext context, int index) => Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/logo-uit.png'),
          ),
          title: Text(notis[index].title),
          subtitle: Text(notis[index].usercreate.username +
              ' ' +
              notis[index].content +
              ' ' +
              notis[index].courseID),
          trailing: Text('2h'),
          onTap: () {
            //push vào buổi
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: 'Thông báo',
        openDrawer: () => _scaffoldKey.currentState.openDrawer(),
      ),
      drawer: widget.drawer,
      body: StreamBuilder<List<Noti>>(
        initialData: [],
        stream: notiList,
        builder: (BuildContext context, AsyncSnapshot<List<Noti>> snapshot) {
          if (snapshot.connectionState != ConnectionState.active)
            return Text('Loading...');
          else {
            if (snapshot.data.length == 0) {
              return Text('Nothing to show...');
            }
            return _buildListNoti(snapshot.data);
          }
        },
      ),
    );
  }
}
