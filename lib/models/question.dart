class Question {
  final int questionID;
  final String questionText;
  final String questionType;
  final int formId;

  Question({
    required this.questionID,
    required this.questionText,
    required this.questionType,
    required this.formId,
});

  Map<String, dynamic> toMap() {
    return {
      'QuestionID': questionID,
      'QuestionText': questionText,
      'QuestionType': questionType,
      'FormId': formId,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionID: map['QuestionID'],
      questionText: map['QuestionText'],
      questionType: map['QuestionType'],
      formId: map['FormId'],
    );
  }
}

