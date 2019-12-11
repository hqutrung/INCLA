import 'package:flutter/material.dart';

class RateDetail extends StatefulWidget {
  @override
  _RateDetailState createState() => _RateDetailState();
}

class _RateDetailState extends State<RateDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo-uit.png'),
                backgroundColor: Colors.white,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Huỳnh Quốc Trung - 17520184',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Buổi học rất bổ ích')
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('5.0'),
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
