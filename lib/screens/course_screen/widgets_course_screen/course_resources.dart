import 'package:document/models/course.dart';
import 'package:document/models/resource.dart';
import 'package:document/services/collection_firestore.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CourseResources extends StatefulWidget {
  CourseResources();

  @override
  _CourseResourcesState createState() => _CourseResourcesState();
}

class _CourseResourcesState extends State<CourseResources> {
  Stream<List<Resource>> resourceStream;
  Course course;

  void initState() {
    course = Provider.of<Course>(context, listen: false);
    resourceStream =
        Collection<Resource>(path: 'course/${course.courseID}/resource')
            .streamData();
    super.initState();
  }

  showAddResourceDialog(BuildContext context, Course course) async {
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
                    FireStoreHelper().createResource(
                        course,
                        _nameEditingController.text,
                        _linkEditingController.text);
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  showEditResourceDialog(BuildContext context, Course course) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          TextEditingController _textEditingController =
              TextEditingController();
          return AlertDialog(
            content: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Nội dung buổi học',
                  ),
                ))
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
                    //     .editResource(course, _nameEditingController.text, _linkEditingController.text);
                    // Navigator.pop(context);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Course course = Provider.of<Course>(context);
    return StreamBuilder<List<Resource>>(
      stream: resourceStream,
      builder: (context, snapshot) {
        print('snapshot = ' + snapshot.data.toString());
        if (snapshot.hasData) {
          return Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  showAddResourceDialog(context, course);
                },
                label: Text('Tài liệu'),
                icon: Icon(Icons.add),
              ),
              body: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) => Card(
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    child: ListTile(
                      leading: Icon(Icons.insert_drive_file),
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].link),
                      onTap: () {
                        //View document
                      },
                    ),
                    actions: <Widget>[
                      IconSlideAction(
                          color: Colors.red,
                          icon: Icons.delete_outline,
                          onTap: () => FireStoreHelper()
                              .deleteResource(course, snapshot.data[index].name)),
                      IconSlideAction(
                        color: Colors.green,
                        icon: Icons.edit,
                        onTap: () {
                          showEditResourceDialog(context, course);
                        },
                      ),
                    ],
                  ),
                ),
              ));
        } else
          return Text('Loading... ' + snapshot.connectionState.toString());
      },
    );
  }
}
