import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document/models/user_infor.dart';
import 'package:document/services/firestore_helper.dart';

class Course {
  String courseID;
  String name;
  DocumentReference reference;
  String teachername;

  List<UserInfor> cachedStudents;

  Course.fromMap(Map data, {this.courseID, this.reference}) {
    if (courseID == null) courseID = data['courseID'];
    name = data['name'];
    teachername = data['teachername'];
    
    getAllMembersAsync();
  }

  Future<List<UserInfor>> getAllMembersAsync() async {
    if (cachedStudents == null) {
      cachedStudents = await FireStoreHelper().getStudentFromUserCourse(courseID);
    }
    return cachedStudents;
  }

  Future<List<Map<String, dynamic>>> getAllMembersArray() async {
    if (cachedStudents == null) await getAllMembersAsync();
    List<Map<String, dynamic>> listMap = List<Map<String, dynamic>>();
    for (int i = 0; i < cachedStudents.length; i++) {
      Map<String, dynamic> x = {'userID': cachedStudents[i].userID, 'username': cachedStudents[i].username};
      listMap.add(x);
    }
    return listMap;
  }

  
}
