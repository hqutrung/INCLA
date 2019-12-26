import 'dart:io';
import 'dart:async';

import 'package:charts_flutter/flutter.dart';
import 'package:document/services/auth_service.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

class ImportScreen extends StatefulWidget {
  @override
  _ImportScreenState createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  String path;

  Future getExcelFilePath() async {
    path = await FilePicker.getFilePath(
        type: FileType.CUSTOM, fileExtension: 'xlsx');
    getExcelData();
  }

  Future getExcelData() async {
    var decoder = SpreadsheetDecoder.decodeBytes(File(path).readAsBytesSync());
    getAccount(decoder.tables['User']);
    // getCourse(decoder.tables['courses']);
    // getSession(decoder.tables['Session']);
    // getUserCourse(decoder.tables['User_courses']);
    // await getRates(decoder.tables['rate']);
    // await getAttendance(decoder.tables['attendance']);
  }

  Future getAccount(SpreadsheetTable table) async {
    AuthService _auth = AuthService();
    // for (var row in table.rows) {
    //   print("$row");
    // }
    for (int i = 1; i < table.rows.length; i++) {
      print(table.rows[i][6]);
      String email = table.rows[i][0];
      String password = table.rows[i][1].toString();
      String userID = '';
      if (table.rows[i][2].runtimeType == double)
        userID = (table.rows[i][2] as double).toInt().toString();
      else
        userID = table.rows[i][2];
      String username = table.rows[i][3];
      int userType = (table.rows[i][4] as double).toInt();
      String phoneNumber = table.rows[i][5];
      DateTime birthday = (DateTime.parse(table.rows[i][6]));
      String degree = table.rows[i][7];
      // await _auth.signUp(email, password);
      await FireStoreHelper().addUserForAdmin(
        email: email,
        userID: userID,
        username: username,
        userType: userType,
        phoneNumber: phoneNumber,
        birthday: birthday,
        degree: degree,
      );
    }
  }

  Future getCourse(SpreadsheetTable table) async {
    for (int i = 1; i < table.rows.length; i++) {
      String courseID = table.rows[i][0];
      String name = table.rows[i][1];
      String teacherName = table.rows[i][2];

      await FireStoreHelper().addCourseForAdmin(
        courseID: courseID,
        name: name,
        teacherName: teacherName,
      );
    }
  }

  Future getSession(SpreadsheetTable table) async {
    DateFormat format = DateFormat('dd/MM/yyyy hh:mm:ss');
    for (int i = 1; i < table.rows.length; i++) {
      DateTime start = format.parse(table.rows[i][1].toString());
      DateTime end = format.parse(table.rows[i][2].toString());
      String topic = table.rows[i][3];
      String courseID = table.rows[i][4];
      await FireStoreHelper().addSessionForAdmin(
        start: start,
        end: end,
        topic: topic,
        courseID: courseID,
      );
    }
  }

  Future getUserCourse(SpreadsheetTable table) async {
    for (int i = 1; i < table.rows.length; i++) {
      String courseID = table.rows[i][0];
      String name = table.rows[i][1];
      String teacherName = table.rows[i][2];
      String userID = '';
      if (table.rows[i][3].runtimeType == double)
        userID = (table.rows[i][3] as double).toInt().toString();
      else
        userID = table.rows[i][3];
      String username = table.rows[i][4];
      // FireStoreHelper().deleteUserForAdmin(username: username);
      // continue;
      int usertype = (table.rows[i][5] as double).toInt();
      await FireStoreHelper().addUserCourseForAdmin(
        courseID: courseID,
        name: name,
        teacherName: teacherName,
        userID: userID,
        username: username,
        user_type: usertype,
      );
      print(i);
    }
    print('add user course done');
  }

  Future getRates(SpreadsheetTable table) async {
    DateFormat format = DateFormat('dd/MM/yyyy hh:mm:ss');

    for (int i = 1; i < table.rows.length; i++) {
      int sessionID = (table.rows[i][0] as double).toInt();
      String courseID = table.rows[i][1];
      String userID = '';
      if (table.rows[i][2].runtimeType == double)
        userID = (table.rows[i][2] as double).toInt().toString();
      else
        userID = table.rows[i][2];
      String username = table.rows[i][3];
      int value = (table.rows[i][4] as double).toInt();
      String content = table.rows[i][5];
      DateTime timestamp = format.parse(table.rows[i][6]);
      List<String> rates =
          await FireStoreHelper().getAllSessionIDForAdmin(courseID: courseID);
      await FireStoreHelper().rateSessionIDForAdmin(
        sessionID: rates[sessionID - 1],
        courseID: courseID,
        userID: userID,
        username: username,
        value: value,
        content: content,
        timestamp: timestamp,
      );
      print(i);
    }
    print('done rates');
  }

  Future getAttendance(SpreadsheetTable table) async {
    DateFormat format = DateFormat('dd/MM/yyyy hh:mm:ss');

    for (int i = 1; i < table.rows.length; i++) {
      int sessionID = (table.rows[i][0] as double).toInt();
      String courseID = table.rows[i][1];
      int duration = (table.rows[i][2] as double).toInt();
      String userID = '';
      if (table.rows[i][3].runtimeType == double)
        userID = (table.rows[i][3] as double).toInt().toString();
      else
        userID = table.rows[i][3];
      String username = table.rows[i][4];
      int isAttend = (table.rows[i][5] as double).toInt();
      DateTime timestamp = format.parse(table.rows[i][6]);
      List<String> rates =
          await FireStoreHelper().getAllSessionIDForAdmin(courseID: courseID);
      await FireStoreHelper().presentAttendanceForAdmin(
        sessionID: rates[sessionID - 1],
        courseID: courseID,
        userID: userID,
        duration: duration,
        username: username,
        timestamp: timestamp,
        isAttend: isAttend,
      );
      print(i);
    }
    print('done');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text('IMPORT PAGE'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Click to import'),
              onPressed: getExcelFilePath,
            ),
          ],
        ),
      ),
    );
  }
}
