import 'package:flutter/material.dart'; 
 
class Profile extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: Text('Thông tin cá nhân'), 
      ), 
      body: SingleChildScrollView( 
        child: Stack( 
          children: <Widget>[ 
            Column( 
              children: <Widget>[ 
                SizedBox( 
                  width: double.infinity, 
                  height: 130.0, 
                  child: const DecoratedBox( 
                    decoration: const BoxDecoration(color: Colors.cyan), 
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
                    backgroundColor: Colors.amber, 
                    child: Image.asset('assets/images/logo-uit.png'), 
                    // backgroundImage: AssetImage('assets/images/logo-uit.png'), 
                  ), 
                ), 
                Text( 
                  'Lê Thanh Trọng', 
                  style: TextStyle(fontWeight: FontWeight.bold), 
                ), 
                Contact(), 
              ], 
            ), 
          ], 
        ), 
      ), 
    ); 
  } 
} 
 
class Contact extends StatelessWidget { 
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
              mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[ 
                Icon(Icons.call), 
                SizedBox( 
                  width: 120, 
                ), 
                Text('0375475075'), 
              ], 
            ), 
          ), 
          Padding( 
            padding: const EdgeInsets.all(20.0), 
            child: Row( 
              crossAxisAlignment: CrossAxisAlignment.center, 
              mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[ 
                Icon(Icons.call), 
                SizedBox( 
                  width: 120, 
                ), 
                Text('0375475075'), 
              ], 
            ), 
          ), 
          Padding( 
            padding: const EdgeInsets.all(20.0), 
            child: Row( 
              crossAxisAlignment: CrossAxisAlignment.center, 
              mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[ 
                Icon(Icons.call), 
                SizedBox( 
                  width: 120, 
                ), 
                Text('0375475075'), 
              ], 
            ), 
          ), 
          Padding( 
            padding: const EdgeInsets.all(20.0), 
            child: Row( 
              crossAxisAlignment: CrossAxisAlignment.center, 
              mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[ 
                Icon(Icons.call), 
                SizedBox( 
                  width: 120, 
                ), 
                Text('0375475075'), 
              ], 
            ), 
          ), 
          Padding( 
            padding: const EdgeInsets.all(20.0), 
            child: Row( 
              crossAxisAlignment: CrossAxisAlignment.center, 
              mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[ 
                Icon(Icons.call), 
                SizedBox( 
                  width: 120, 
                ), 
                Text('0375475075'), 
              ], 
            ), 
          ), 
          Padding( 
            padding: const EdgeInsets.all(20.0), 
            child: Row( 
              crossAxisAlignment: CrossAxisAlignment.center, 
              mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[ 
                Icon(Icons.call), 
                SizedBox( 
                  width: 120, 
                ), 
                Text('0375475075'), 
              ], 
            ), 
          ), 
        ], 
      ), 
    ); 
  } 
}