import 'package:flutter/material.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang chủ'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) => Card(
          child: ListTile(
            leading: Text('SE312.K12'),
            title: Text('Pháp luật đại cương'),
            subtitle: Text('Huỳnh Như Ý'),
            trailing: Icon(Icons.hotel),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
