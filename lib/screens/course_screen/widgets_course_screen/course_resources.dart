import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CourseResources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text('Tài liệu'),
          icon: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) => Card(
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: ListTile(
                leading: Icon(Icons.insert_drive_file),
                title: Text('Lý thuyết OOP'),
                subtitle: Text('lttoop.doc'),
                    // Text('SE102.K12 - Lập trình hướng Đối tượng'),
                    // Text('Ngày tạo: 20/10/2019'),
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => SessionScreen()));
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
