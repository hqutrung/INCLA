import 'package:document/models/course.dart';
import 'package:document/models/rate.dart';
import 'package:document/models/user.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class RateDetail extends StatefulWidget {
  final String sessionID;

  RateDetail({this.sessionID});

  @override
  _RateDetailState createState() => _RateDetailState();
}

class _RateDetailState extends State<RateDetail> {
  Stream<Rates> ratesStream;
  Course course;
  User user;

  showRatingDialog() {
    return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          TextEditingController _textEditingController =
              TextEditingController();
          int rate = 5;

          return AlertDialog(
            title: Text('Đánh giá'),
            content: Column(
              children: <Widget>[
                Expanded(
                  child: RatingBar(
                    initialRating: 5,
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
                      setState(() {
                        rate = rating.toInt();
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
              FlatButton(
                child: const Text('Lưu'),
                onPressed: () { FireStoreHelper().rateSession(
                  course: course,
                  content: _textEditingController.text,
                  user: user,
                  sessionID: widget.sessionID,
                  value: rate,
                );
                Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    course = Provider.of<Course>(context, listen: false);
    user = Provider.of<User>(context, listen: false);
    ratesStream = FireStoreHelper()
        .getRatesStream(course: course, sessionID: widget.sessionID);
    super.initState();
  }

  Widget _buildRateList(List<Rate> rates) {
    return Column(children: <Widget>[
      Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: rates.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(children: <Widget>[
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
                      '${rates[index].attendance.username} - ${rates[index].attendance.userID}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(rates[index].content)
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(rates[index].star.toString()),
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  )
                ],
              ),
            ]),
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
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Rates>(
      stream: ratesStream,
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData)
            return _buildRateList(snapshot.data.rates);
          else
            return Text('Nothing to show...');
        } else
          return Text('Loading...' + snapshot.connectionState.toString());
      },
    );
  }
}
