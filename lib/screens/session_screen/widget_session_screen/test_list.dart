import 'package:document/models/course.dart';
import 'package:document/models/test.dart';
import 'package:document/models/user.dart';
import 'package:document/screens/session_screen/widget_session_screen/detail_test.dart';
import 'package:document/screens/shared_widgets/confirm_dialog.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class showTest extends StatefulWidget {
  final Course course;
  final String sessionID;

  showTest({@required this.course, @required this.sessionID});

  @override
  _showTestState createState() => _showTestState();
}

class _showTestState extends State<showTest>
    with AutomaticKeepAliveClientMixin {
  Test selectedTest;
  User user;

  bool isTestDetail = false;

  Stream<List<Test>> testsAsyncer;
  Stream<Test> detailTestAsyncer;

  void moveBack() {
    setState(() {
      isTestDetail = !isTestDetail;
    });
  }

  @override
  void initState() {
    updateTestsAsyncer();
    super.initState();
  }

  void updateTestsAsyncer() {
    testsAsyncer = FireStoreHelper()
        .getTestsStream(widget.course.courseID, widget.sessionID);
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    if (!isTestDetail) {
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Import Bài Test
            //
            //
            //
          },
          label: Text('Test'),
          icon: Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: testsAsyncer,
          builder: (context, snapshot) {
            final SlidableController slidableController = SlidableController();
            if (!snapshot.hasData)
              return const Center(child: CircularProgressIndicator());
            else {
              List<Test> tests = snapshot.data;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: tests.length,
                itemBuilder: (BuildContext context, int index) => Card(
                  child: Slidable(
                    closeOnScroll: true,
                    actionExtentRatio: 0.13,
                    key: Key(widget.key.toString()),
                    controller: slidableController,
                    actionPane: SlidableDrawerActionPane(),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage('assets/images/logo-uit.png'),
                      ),
                      title: Text(tests[index].title),
                      subtitle: Text('Thời gian: 15 phút'),
                      onTap: () {
                        setState(() {
                          selectedTest = tests[index];
                          isTestDetail = !isTestDetail;
                          detailTestAsyncer = FireStoreHelper()
                              .getDetailTestStream(
                                  widget.course, selectedTest.uid);
                        });
                      },
                    ),
                    actions: (user.type == UserType.Teacher)
                        ? <Widget>[
                            IconSlideAction(
                                color: Colors.red,
                                icon: Icons.delete_outline,
                                onTap: () {
                                  confirmDialog(context, 'Xác nhận xóa test?',
                                      () {
                                    //Firebase xóa
                                  });
                                }),
                            IconSlideAction(
                                color: Colors.green,
                                icon: Icons.edit,
                                onTap: () {}),
                          ]
                        : null,
                  ),
                ),
              );
            }
          },
        ),
      );
    } else if (isTestDetail) {
      return StreamBuilder<Test>(
          stream: detailTestAsyncer,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return DetailTest(
                moveBack: moveBack,
                test: selectedTest,
              );
            else
              return DetailTest(
                moveBack: moveBack,
                test: snapshot.data,
              );
          });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
