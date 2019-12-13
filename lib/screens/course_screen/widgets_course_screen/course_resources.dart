import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CourseResources extends StatelessWidget {
  @override
  showAddResourceDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          TextEditingController _nameEditingController =
              TextEditingController();
              TextEditingController _linkEditingController =
              TextEditingController();
          return AlertDialog(
            content: Column(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _nameEditingController,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Thông tin tài liệu',
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _linkEditingController,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Link Google Driver',
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              FlatButton(
                  child: const Text('Lưu'),
                  onPressed: () {
                    // FireStoreHelper()
                    //     .createSession(course, _textEditingController.text);
                    // Navigator.pop(context);
                  })
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showAddResourceDialog(context);
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
                  color: Colors.red,
                  icon: Icons.delete_outline,
                  onTap: () {},
                ),
                IconSlideAction(
                  color: Colors.green,
                  icon: Icons.edit,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ));
  }
}
