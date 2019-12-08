import 'package:document/src/firebase/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class VanDe{
  String key;
  String name;
  String title;
  String ngaytao;
  String numRep;
  VanDe(this.name, this.title, this.ngaytao, this.numRep);
  
  VanDe.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    name = snapshot.value["name"],
    title = snapshot.value["title"],
    ngaytao = snapshot.value["ngaytao"],
    numRep = snapshot.value['numRep'];

  toJson() {
    return {
      "name": name,
      "title": title,
      "ngaytao": ngaytao,
      "numRep" : numRep,
    };
  }

}

