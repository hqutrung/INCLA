class Course {
  String courseID;
  String name;

  Course.fromMap(Map data, {this.courseID}) {
    if (courseID == null) courseID = data['courseID'];
    name = data['name'];
  }
}
