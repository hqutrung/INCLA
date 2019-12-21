class Question {
  String question;
  String A;
  String B;
  String C;
  String D;

  Question.fromMap(Map data) {
    question = data['question'];
    A = data['a'];
    B = data['b'];
    C = data['c'];
    D = data['d'];
  }
}