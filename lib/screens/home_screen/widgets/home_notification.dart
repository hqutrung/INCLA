import 'package:document/screens/shared_widgets/main_appbar.dart';
import 'package:document/screens/shared_widgets/main_drawer.dart';
import 'package:flutter/material.dart'; 
 
class HomeNotification extends StatefulWidget { 
  @override 
  _HomeNotificationState createState() => _HomeNotificationState(); 
} 
 
class _HomeNotificationState extends State<HomeNotification> { 
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
        itemCount: 3, 
        itemBuilder: (BuildContext context, int index) { 
          return Container( 
            child: RaisedButton( 
              onPressed: () {}, 
              padding: EdgeInsets.all(10), 
              color: Colors.white, 
              shape: RoundedRectangleBorder( 
                  borderRadius: BorderRadius.circular(5)), 
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: <Widget>[ 
                  Column( 
                    children: <Widget>[ 
                      Image.asset( 
                        'assets/images/logo-uit.png', 
                        width: 40, 
                        height: 40, 
                      ) 
                    ], 
                  ), 
                  Column( 
                      mainAxisAlignment: MainAxisAlignment.start, 
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: <Widget>[ 
                        Text( 
                          'Phap Luat Dai Cuong', 
                          style: TextStyle( 
                            fontSize: 20, 
                          ), 
                        ), 
                        Text( 
                          'Nguyen Minh Hoang', 
                          style: TextStyle( 
                            fontSize: 10, 
                          ), 
                        ), 
                      ]), 
                  Column( 
                    mainAxisAlignment: MainAxisAlignment.center, 
                    crossAxisAlignment: CrossAxisAlignment.end, 
                    children: <Widget>[ 
                      Text( 
                        '2h', 
                        style: TextStyle( 
                          fontSize: 20, 
                        ), 
                      ), 
                    ], 
                  ), 
                ], 
              ), 
            ), 
          ); 
        }, 
      ), 
    ); 
  } 
} 
