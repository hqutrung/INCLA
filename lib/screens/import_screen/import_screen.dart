import 'dart:io';
import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

class ImportScreen extends StatefulWidget {
  @override
  _ImportScreenState createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  String path;

  Future getExcelFilePath() async {
    path = await FilePicker.getFilePath(type: FileType.CUSTOM, fileExtension: 'xlsx');
    getExcelData();
  }

  Future getExcelData() async {
    var decoder = SpreadsheetDecoder.decodeBytes(File(path).readAsBytesSync());
    for (var table in decoder.tables.keys) {
      print(table);
      print(decoder.tables[table].maxCols);
      print(decoder.tables[table].maxRows);
      for (var row in decoder.tables[table].rows) {
        print("$row");
      }
    }
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
