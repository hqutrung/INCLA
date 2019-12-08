import 'package:flutter/material.dart';

class showSinhVien extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) => Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo-uit.png'),
            backgroundColor: Colors.white,
          ),
          title: Text('Huỳnh Quốc Trung'),
          subtitle: Text('MSSV: 17520184'),
          onTap: () {
            //Navigator.push(context,MaterialPageRoute(builder: (context) => SessionScreen()));
          },
        ),
      ),
    );
  }
}
