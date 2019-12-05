import 'package:document/src/firebase/firebase_auth.dart';

class VanDe{
  String name;
  String title;
  String ngaytao;
  int numRep;
  VanDe(this.name, this.title, this.ngaytao, this.numRep);
  VanDe.map(dynamic obj)
  {
    this.name = obj['createby'];
    this.title = obj['title'];
    this.ngaytao = obj['createat'];
    this.numRep = obj['reply'];
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map['createby'] = name;
    map['title']=title;
    map['createat']=ngaytao;
    map['reply']=numRep;
  }

  VanDe.fromMap(Map<String, dynamic> map){
  this.name = map['createby'];
  this.title = map['title'];
  this.ngaytao = map['createat'];
  this.numRep = map['reply'];
  }

}

