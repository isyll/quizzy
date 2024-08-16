import 'dart:convert';

class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final int? choosenAnswer;

  Question(
      {required this.questionText,
      required this.options,
      required this.correctAnswerIndex,
      this.choosenAnswer});

  bool get isCorrect => choosenAnswer == correctAnswerIndex;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'questionText': questionText});
    result.addAll({'options': options});
    result.addAll({'correctAnswerIndex': correctAnswerIndex});

    return result;
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionText: map['questionText'] ?? '',
      options: List<String>.from(map['options']),
      correctAnswerIndex: map['correctAnswerIndex']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));
}
