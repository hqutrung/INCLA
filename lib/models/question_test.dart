class Question {
  String question;
  String A;
  String B;
  String C;
  String D;

  Question({this.question, this.A, this.B,this.C,this.D});

  Question.fromMap(Map data) {
    question = data['question'];
    A = data['a'];
    B = data['b'];
    C = data['c'];
    D = data['d'];
  }

  Map<String, dynamic> toMap() {
    return {
      'a': A,
      'b': B,
      'c': C,
      'd': D,
      'question': question,
    };
  }
}
