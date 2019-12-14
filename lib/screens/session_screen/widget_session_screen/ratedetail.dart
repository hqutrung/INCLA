import 'package:document/models/course.dart';
import 'package:document/models/rate.dart';
import 'package:document/models/user.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    course = Provider.of<Course>(context, listen: false);
    user = Provider.of<User>(context, listen: false);
    ratesStream = FireStoreHelper()
        .getRatesStream(course: course, sessionID: widget.sessionID);
    super.initState();
  }

  Widget _buildRateList(List<Rate> rates) {
    return Container(
      child: ListView.builder(
        itemCount: rates.length,
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Rates>(
      stream: ratesStream,
      builder: (context, snapshot) {
        // print('wtf');
        // return Container(
        //   height: 50,
        //   width: 100,
        //   child: IconButton(
        //     icon: Icon(Icons.star),
        //     color: Colors.blue,
        //     onPressed: () {
        //       // FireStoreHelper()
        //       //     .createRates(course: course, sessionID: widget.sessionID);
        //       FireStoreHelper().rateSession(
        //           course: course,
        //           sessionID: widget.sessionID,
        //           user: user,
        //           content: '',
        //           value: 5);
        //     },
        //   ),
        // );
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
