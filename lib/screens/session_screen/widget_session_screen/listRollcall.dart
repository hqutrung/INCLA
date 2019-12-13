import 'package:document/models/attendance.dart';
import 'package:document/models/user_infor.dart';
import 'package:flutter/material.dart';

class AttendanceList extends StatefulWidget {
  final Attendance attendance;

  AttendanceList({@required this.attendance});

  @override
  _AttendanceListState createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    List<UserInfor> online = widget.attendance.online;
    List<UserInfor> offline = widget.attendance.offline;
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: TabBar(
              controller: _tabController,
              tabs: <Widget>[
                Tab(child: Text('Đã điểm danh')),
                Tab(child: Text('Chưa điểm danh')),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              ListView.builder(
                itemCount: online.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/logo-uit.png'),
                    ),
                    title: Text(
                      online[index].username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('MSSV: ${online[index].userID}'),
                    trailing: Icon(
                      Icons.brightness_1,
                      color: Colors.green,
                      size: 10,
                    ),
                  ),
                ),
              ),
              ListView.builder(
                itemCount: offline.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/logo-uit.png'),
                    ),
                    title: Text(
                      offline[index].username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('MSSV: ${offline[index].userID}}'),
                    trailing: Icon(
                      Icons.brightness_1,
                      color: Colors.grey,
                      size: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
