import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document/models/user_infor.dart';
import 'package:document/services/firestore_helper.dart';

class Course {
  String courseID;
  String name;
  DocumentReference reference;
  List<UserInfor> members;

  Course.fromMap(Map data, {this.courseID, this.reference}) {
    if (courseID == null) courseID = data['courseID'];
    name = data['name'];
    getAllMembers();
  }

  Future<List<UserInfor>> getAllMembers() async {
    if (members == null)
      members = await FireStoreHelper().getStudents(courseID);
    print('length: ' + members.length.toString());
    return members;
  }

  Future<List<Map<String, dynamic>>> getAllMembersArray() async {
    if (members == null) await getAllMembers();
    List<Map<String, dynamic>> listMap = List<Map<String, dynamic>>();
    for (int i = 0; i < members.length; i++) {
      Map<String, dynamic> x = {'userID': members[i].userID, 'username': members[i].username};
      listMap.add(x);
    }
    return listMap;
  }
}
