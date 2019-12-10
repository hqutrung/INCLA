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
    return DefaultTabController(
      length:2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorWeight: 4.0,
            indicatorColor:Color(0xffff5722),
            unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(

                child:Text('For You'),
              ),
              Tab(
                
                child: Text('Top Charts'),
              ),
              
            ],
          ),
        ),
         body: TabBarView(
           controller: _tabController,
            children: <Widget>[
              Text('abc'),
              Text('andc'),
           
            ],
         ),
      ),
    );
  }
}
