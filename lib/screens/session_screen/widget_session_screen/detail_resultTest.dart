import 'package:flutter/material.dart';

class ResultTest extends StatefulWidget {
  @override
  _ResultTestState createState() => _ResultTestState();
}

class _ResultTestState extends State<ResultTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bảng điểm kiểm tra'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: const AssetImage('assets/images/logo-uit.png'),
              radius: 25,
            ),
            title: Text(
              'Huỳnh Quốc Trung',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('MSSV: 17520184'),
            trailing: Text('10 điểm',),
          ),
        ),
      ),
    );
  }
}
