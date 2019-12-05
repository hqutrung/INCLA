import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document/src/firebase/firebase_auth.dart';
import 'package:document/src/models/document_model.dart';
import 'package:document/src/models/vande_model.dart';
import 'package:document/src/ui/thaoluan_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class VanDePage extends StatefulWidget {
  @override
  _VanDePageState createState() => _VanDePageState();
}



class _VanDePageState extends State<VanDePage> {
  List<VanDe> vandes;
  StreamSubscription<QuerySnapshot> vande;
  @override
  void initState()
  {
    super.initState();
    vandes=new List();
    vande?.cancel();
  }
  _vande() {
    return ListView.builder(
        itemCount: vandes.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Slidable(
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Xóa',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {
                      setState(() {
                        vandes.removeAt(index);
                      });
                    },
                  )
                ],
                actionPane: SlidableBehindActionPane(),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ThaoLuanPage(vande: vandes[index])));
                  },
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.insert_drive_file,
                        size: 65,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              vandes[index].title,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Người tạo: ' + vandes[index].name,
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  vandes[index].ngaytao,
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  vandes[index].numRep.toString() + ' Trả lời',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            )
                          ]),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('2h'),
                          IconButton(
                            splashColor: Colors.white,
                            onPressed: () {
                              setState(() {

                              });
                            },
                            icon: Icon(
                              Icons.star,

                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thảo luận'),
      ),
      body: _vande(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
