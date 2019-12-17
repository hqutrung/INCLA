class Question {
  String question;
  String result;
  String A;
  String B;
  String C;
  String D;

  Question.fromMap(Map data) {
    print('question: ' + question + '-' + result + '{' + A + ','+ B + ',' + C + ',' + D + '}');
    question = data['question'];
    result = data['result'];
    A = data['A'];
    B = data['B'];
    C = data['C'];
    D = data['D'];
  }
}