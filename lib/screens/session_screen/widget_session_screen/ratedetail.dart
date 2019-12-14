import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateDetail extends StatefulWidget {
  @override
  _RateDetailState createState() => _RateDetailState();
}

class _RateDetailState extends State<RateDetail> {
  showRatingDialog() {
    return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          double rate;
          TextEditingController _textEditingController =
              TextEditingController();
          return AlertDialog(
            title: Text('Đánh giá'),
            content: Column(
              children: <Widget>[
                Expanded(
                  child: RatingBar(
                    initialRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemSize: 35,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                      setState(() {
                        rate=rating;
                      });
                    },
                    
                  ),
                
                ),
                
                Expanded(
                    child: TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Nội dung',
                  ),
                ))
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              FlatButton(child: const Text('Lưu'), onPressed: () {
                print('cos $rate');
              })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
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
        ),
        FlatButton(
          color: ThemeData().primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () {
            showRatingDialog();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
            child: Text(
              'Tạo đánh giá',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
