import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_infor.dart';

class Rate {
  UserInfor attendance;
  double star;
  String content;

  Rate.fromMap(Map data) {
    attendance = UserInfor(
      userID: data['userID'],
      username: data['username'],
    );
    if (data['value'].runtimeType == int)
      star = (data['value'] as int).toDouble();
    else
      star = data['value'] as double;
    content = data['content'];

  }
}

class Rates {
  List<Rate> rates;
  DateTime timestamp;

  Rates.fromMap(Map data) {
    rates = (data['rates'] as List ?? [])
        .map((rate) => Rate.fromMap(rate))
        .toList();
    timestamp = (data['timestamp'] as Timestamp).toDate();
  }
}
