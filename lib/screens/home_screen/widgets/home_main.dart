import 'package:document/screens/shared_widgets/main_appbar.dart';
import 'package:document/screens/shared_widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: 'Thông báo',
        openDrawer: () => _scaffoldKey.currentState.openDrawer(),
      ),
      drawer: MainDrawer(),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) => Card(
          child: ListTile(
            leading: Text('SE312.K12'),
            title: Text('Pháp luật đại cương'),
            subtitle: Text('Huỳnh Như Ý'),
            trailing: Icon(
              Icons.hotel,
              color: Colors.black,
            ),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
