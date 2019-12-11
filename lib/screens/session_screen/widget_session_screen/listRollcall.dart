import 'package:flutter/material.dart';

class showListRollCall extends StatefulWidget {
  @override
  _showListRollCallState createState() => _showListRollCallState();
}

class _showListRollCallState extends State<showListRollCall>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Danh sach',
            ),
            bottom: TabBar(
              controller: _tabController,
              tabs: <Widget>[
                Tab(
                  child: Text('Đã điểm danh'),
                ),
                Tab(
                  child: Text('Chưa điểm danh'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/logo-uit.png'),
                  ),
                  title: Text('Huỳnh Quốc Trung', style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                 trailing: Icon(Icons.brightness_1, color: Colors.green,size: 10,),
                ),

                ),
              ),
              ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/logo-uit.png'),
                  ),
                  title: Text('Huỳnh Quốc Trung', style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                 trailing: Icon(Icons.brightness_1, color: Colors.grey,size: 10,),
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
