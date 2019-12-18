import 'package:document/models/notification.dart';
import 'package:document/models/user.dart';
import 'package:document/screens/session_screen/session_screen.dart';
import 'package:document/screens/shared_widgets/confirm_dialog.dart';
import 'package:document/screens/shared_widgets/main_appbar.dart';
import 'package:document/screens/shared_widgets/main_drawer.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeNotification extends StatefulWidget {
  final MainDrawer drawer;

  const HomeNotification({Key key, @required this.drawer}) : super(key: key);
  @override
  _HomeNotificationState createState() => _HomeNotificationState();
}

class _HomeNotificationState extends State<HomeNotification> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String userID;
  Stream<List<Noti>> notiList;

  @override
  void initState() {
    User user = Provider.of<User>(context, listen: false);
    userID = user.uid;
    notiList = FireStoreHelper().getNotification(userID: user.uid);

    super.initState();
  }

  Widget _buildListNoti(List<Noti> notis) {
    notis.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: notis.length,
      itemBuilder: (BuildContext context, int index) => Card(
        color: notis[index].isRead ? Colors.white : Colors.grey[300],
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
          trailing: IconButton(
            onPressed: () {
              confirmDialog(context, 'Xác nhận xóa thông báo', () {
                FireStoreHelper().deleteNoti(userID, notis[index]);
              });
            },
            icon: Icon(Icons.more_horiz),
          ),
          onTap: () {
            setState(() {
              notis[index].isRead = true;
              FireStoreHelper().updateIsReadNoti(userID, notis[index]);
            });

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
            return const Center(child: CircularProgressIndicator());
          else {
            if (snapshot.data.length == 0) {
              return Center(
                  child: Text('Bạn chưa có thông báo nào',
                      style: TextStyle(fontSize: 20)));
            }
            return _buildListNoti(snapshot.data);
          }
        },
      ),
    );
  }
}
