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

  @override
  Widget build(BuildContext context) {
    Course course = Provider.of<Course>(context, listen: false);
    User user = Provider.of<User>(context, listen: false);
    return Scaffold(
        body: Column(children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: widget.test.questions.length + 1,
              itemBuilder: (context, index) => (index == 0)
                  ? Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            widget.test.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(widget.test.time.toString()),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Thời gian: 15 phút',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  '$_start s',
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 10.0,
                        ),
                      ],
                    )
                  : Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Slidable(
                          actionPane: Container(),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.test.questions[index - 1].question,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
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
