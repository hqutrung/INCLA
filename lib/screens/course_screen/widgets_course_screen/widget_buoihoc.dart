import 'package:document/screens/session_screen/session_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class showBuoiHoc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text('Tạo buổi'),
          icon: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) => Card(
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: ListTile(
                title: Text('Chương 1: Giới thiệu chung'),
                subtitle: Text('Tuần $index - Ngày 10/10/2019'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SessionScreen()));
                },
              ),
              actions: <Widget>[
                
                IconSlideAction(
                  caption: 'Xoá',
                  color: Colors.red,
                  icon: Icons.delete_outline,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ));
  }
}
