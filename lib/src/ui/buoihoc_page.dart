import 'package:flutter/material.dart';

import 'document_page.dart';
import 'vande_page.dart';

class BuoiHocPage extends StatefulWidget {
  @override
  _BuoiHocPageState createState() => _BuoiHocPageState();
}

class _BuoiHocPageState extends State<BuoiHocPage> {
  @override
  _document() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: RaisedButton(
        padding: EdgeInsets.all(10),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DocumentPage()));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side:  BorderSide(color: Colors.blue)
        ),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.subject),
            Text('Tài liệu',
            style: TextStyle(
              fontSize: 20,
            ),),
          ],
        ),
      ),
    );
  }

  _kiemtra() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: RaisedButton(
        padding: EdgeInsets.all(10),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DocumentPage()));
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side:  BorderSide(color: Colors.blue)
        ),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check_box),
            Text('Kiểm tra',
              style: TextStyle(
                fontSize: 20,
              ),),
          ],
        ),
      ),
    );
  }

  _thaoluan() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: RaisedButton(
        padding: EdgeInsets.all(10),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => VanDePage()));
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side:  BorderSide(color: Colors.blue)
        ),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.comment),
            Text('Thảo luận',
              style: TextStyle(
                fontSize: 20,
              ),),
          ],
        ),
      ),
    );
  }

  _diemdanh() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: RaisedButton(
        padding: EdgeInsets.all(10),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DocumentPage()));
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side:  BorderSide(color: Colors.blue)
        ),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.assignment_turned_in),
            Text('Điểm danh',
              style: TextStyle(
                fontSize: 20,
              ),),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lập trình trên thiết bị di động - SE346.K11'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _document(),
            _kiemtra(),
            _thaoluan(),
            _diemdanh(),
          ],
        )
      ),
    );
  }
}
