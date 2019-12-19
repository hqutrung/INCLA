import 'dart:async';

import 'package:document/models/test.dart';
import 'package:document/models/question_test.dart';
import 'package:document/models/course.dart';
import 'package:document/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:document/screens/shared_widgets/confirm_dialog.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DetailTest extends StatefulWidget {
  final Test test;
  final Function moveBack;

  DetailTest({@required this.test, @required this.moveBack});

  @override
  _DetailTestState createState() => _DetailTestState();
}

class _DetailTestState extends State<DetailTest> {
  Timer _timer;
  int _start = 900;
  int minutes;
  int seconds;
  List<int> selection = List.filled(10, 0, growable: true);

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            widget.moveBack;
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
    super.initState();
  }

  listTest() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Column(
            children: <Widget>[
              Text(
                'Caau $index: 2 + 3 =  maays??',
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
                              print(selection);
                            });
                          },
                          value: 1),
                      Text('5'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                        groupValue: selection[index],
                        onChanged: (value) {
                          setState(() {
                            selection[index] = value;
                            print(selection);
                          });
                        },
                        value: 2,
                      ),
                      Text('5'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                          groupValue: selection[index],
                          onChanged: (value) {
                            setState(() {
                              selection[index] = value;
                              print(selection);
                            });
                          },
                          value: 3),
                      Text('5'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                          groupValue: selection[index],
                          onChanged: (value) {
                            setState(() {
                              selection[index] = value;
                              print(selection);
                            });
                          },
                          value: 4),
                      Text('5'),
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
              'Kieem tra chuong 1',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('22/22/2222'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Thoiwf gian: 15 phut'),
              Text('$_start s'),
            ],
          ),
          Divider(),
          Expanded(
            child: listTest(),
          ),
        ]),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                  onPressed: () {},
                  child: Text('Nộp bài'),
                  color: Colors.green),
              FlatButton(
                onPressed: widget.moveBack,
                child: Text('Hủy'),
                color: Colors.black12,
              ),
            ],
          ),
        ));
  }
}
