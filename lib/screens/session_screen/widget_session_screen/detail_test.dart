import 'dart:async';

import 'package:document/models/course.dart';
import 'package:document/models/test.dart';
import 'package:document/models/user.dart';
import 'package:document/screens/session_screen/widget_session_screen/detail_resultTest.dart';
import 'package:document/screens/shared_widgets/confirm_dialog.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:document/utils/CompareLists.dart';
import 'package:document/utils/ConvertDateTime.dart';
import 'package:document/utils/ConvertResult.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailTest extends StatefulWidget {
  final Test test;
  final Function moveBack;

  DetailTest({@required this.test, @required this.moveBack});

  @override
  _DetailTestState createState() => _DetailTestState();
}

class _DetailTestState extends State<DetailTest> {
  Timer _timer;
  int _start = 900; // 15 phút
  List<int> selection;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            widget.moveBack();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    selection = List.filled(widget.test.questions.length, 0, growable: true);
    super.initState();
  }

  listTeacherTest() {
    return ListView.builder(
      itemCount: widget.test.questions.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Câu ${index + 1}: ' + widget.test.questions[index].question,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      'A: ' + widget.test.questions[index].A,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      'B: ' + widget.test.questions[index].B,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      'C: ' + widget.test.questions[index].C,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      'D: ' + widget.test.questions[index].D,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      'Đáp án: ' + ConvertResult(widget.test.results[index]),
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  listStudentTest() {
    return ListView.builder(
      itemCount: widget.test.questions.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Column(
            children: <Widget>[
              Text(
                'Câu ${index + 1}: ' + widget.test.questions[index].question,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio(
                          groupValue: selection[index],
                          onChanged: (value) {
                            setState(() {
                              selection[index] = value;
                            });
                          },
                          value: 1),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.test.questions[index].A,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                        groupValue: selection[index],
                        onChanged: (value) {
                          setState(() {
                            selection[index] = value;
                          });
                        },
                        value: 2,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.test.questions[index].B,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                          groupValue: selection[index],
                          onChanged: (value) {
                            setState(() {
                              selection[index] = value;
                            });
                          },
                          value: 3),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.test.questions[index].C,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                          groupValue: selection[index],
                          onChanged: (value) {
                            setState(() {
                              selection[index] = value;
                            });
                          },
                          value: 4),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.test.questions[index].D,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Course course = Provider.of<Course>(context, listen: false);
    User user = Provider.of<User>(context, listen: false);
    return Scaffold(
        body: Column(children: <Widget>[
          ListTile(
            title: Text(
              widget.test.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Ngày tạo: ' + ConvertDateTime(widget.test.time)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[Text('Thời gian: 15 phút'), Text('$_start s')],
          ),
          Divider(),
          Expanded(
            child: (user.type == UserType.Student)
                ? listStudentTest()
                : listTeacherTest(),
          ),
        ]),
        bottomNavigationBar: (user.type == UserType.Student)
            ? BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                        onPressed: () {
                          confirmDialog(context, 'Xác nhận nộp bài?', () {
                            FireStoreHelper().createResult(
                                course,
                                widget.test.uid,
                                user,
                                CompareLists(widget.test.results, selection),
                                selection);
                            widget.moveBack();
                          });
                        },
                        child: Text('Nộp bài'),
                        color: Colors.green),
                    FlatButton(
                      onPressed: () => confirmDialog(context,
                          'Xác nhận kết thúc bài kiểm tra?', widget.moveBack),
                      child: Text('Hủy'),
                      color: Colors.black12,
                    ),
                  ],
                ),
              )
            : BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                        onPressed: () => confirmDialog(context,
                            'Xác nhận kết thúc bài kiểm tra?', widget.moveBack),
                        child: Text('Kết thúc'),
                        color: Colors.red),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ResultTest(results: widget.test.students)));
                      },
                      child: Text('Kết quả'),
                      color: Colors.black12,
                    ),
                  ],
                ),
              ));
  }
}
