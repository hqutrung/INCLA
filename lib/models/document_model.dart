

import 'package:document/models/class_model.dart';

class Document{
  String _name;

  String get name => _name;

  set name(String name) {
    _name = name;
  }
  String _file;

  String get file => _file;

  set file(String file) {
    _file = file;
  }
  String _url;

  String get url => _url;

  set url(String url) {
    _url = url;
  }
  Lop _lop;


  Lop get lop => _lop;


  String _ngaytao;

  String get ngaytao => _ngaytao;

  set ngaytao(String ngaytao) {
    _ngaytao = ngaytao;
  }

  Document(
      this._name,
      this._file,
      this._url,
      this._lop,
      this._ngaytao,
      );
}

final Lop SE102K12 =  Lop('SE102.K12', 'Lập trình hướng đối tượng');
final Lop SE114K12 = Lop('SE114.K12', 'Nhập môn di động');

final List<Document> documents = [
  Document('Lý thuyết OOP', 'ltOOP.doc', 'abc/ltOOP.doc', SE102K12, '11/11/2019' ),
  Document('Nhập môn di dộng', 'mobile.doc', 'abc/mobile.doc', SE114K12, '11/12/2019'),
];