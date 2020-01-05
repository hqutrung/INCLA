import 'dart:io';

import 'package:document/models/course.dart';
import 'package:document/models/question_test.dart';
import 'package:document/models/test.dart';
import 'package:document/models/user.dart';
import 'package:document/screens/session_screen/widget_session_screen/detail_test.dart';
import 'package:document/screens/shared_widgets/confirm_dialog.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

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
    user = Provider.of<User>(context, listen: false);
    super.initState();
  }

  void updateTestsAsyncer() {
    testsAsyncer = FireStoreHelper()
        .getTestsStream(widget.course.courseID, widget.sessionID);
  }

  String path;

  Future getExcelFilePath() async {
    path = await FilePicker.getFilePath(
        type: FileType.CUSTOM, fileExtension: 'xlsx');
    getExcelData();
  }

  Future getExcelData() async {
    var decoder = SpreadsheetDecoder.decodeBytes(File(path).readAsBytesSync());
    await createTest(decoder.tables['test_sql']);
  }

  Future createTest(SpreadsheetTable table) async {
    String title = table.rows[1][0];
    int count = table.rows[1][1];
    List<Question> questions = List<Question>();
    List<int> results = List<int>();
    for (int i = 1; i <= count; i++) {
      String content = table.rows[i][2].toString();
      String a = table.rows[i][3].toString();
      String b = table.rows[i][4].toString();
      String c = table.rows[i][5].toString();
      String d = table.rows[i][6].toString();
      int result = table.rows[i][7];
      questions.add(Question(question: content, A: a, B: b, C: c, D: d));
      results.add(result);
    }
    await FireStoreHelper().addTest(
      course: widget.course,
      questions: questions,
      results: results,
      sessionID: widget.sessionID,
      title: title,
    );
  }

  Widget _buildTestList() {
    return StreamBuilder(
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
                    backgroundImage: AssetImage('assets/images/logo-uit.png'),
                  ),
                  title: Text(tests[index].title),
                  subtitle: Text('Thời gian: 15 phút'),
                  onTap: () {
                    setState(() {
                      selectedTest = tests[index];
                      isTestDetail = !isTestDetail;
                      detailTestAsyncer = FireStoreHelper()
                          .getDetailTestStream(widget.course, selectedTest.uid);
                    });
                  },
                ),
                actions: (user.type == UserType.Teacher)
                    ? <Widget>[
                        IconSlideAction(
                            icon: Icons.delete_outline,
                            onTap: () {
                              confirmDialog(context, 'Xác nhận xóa test?', () {
                                //Firebase xóa
                              });
                            }),
                        IconSlideAction(icon: Icons.edit, onTap: () {}),
                      ]
                    : null,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isTestDetail) {
      if (user.type == UserType.Teacher)
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: getExcelFilePath,
            label: Text('Test'),
            icon: Icon(Icons.add),
          ),
          body: _buildTestList(),
        );
      else
        return Scaffold(
          body: _buildTestList(),
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
