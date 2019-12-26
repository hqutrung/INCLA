import 'package:document/models/result.dart';
import 'package:document/utils/ConvertDateTime.dart';
import 'package:flutter/material.dart';

class ResultTest extends StatefulWidget {
  final List<Result> results;

  ResultTest({@required this.results});

  @override
  _ResultTestState createState() => _ResultTestState();
}

class _ResultTestState extends State<ResultTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách sinh viên đẫ kiểm tra'),
      ),
      body: ListView.builder(
        itemCount: widget.results.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: const AssetImage('assets/images/logo-uit.png'),
              radius: 25,
            ),
            title: Text(
              widget.results[index].attendance.username,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.results[index].attendance.userID + ' - Nộp bài: '+ ConvertDateTime(widget.results[index].time)),
            trailing: Text(widget.results[index].point.toString() + 'điểm',),
          ),
        ),
      ),
    );
  }
}
