class Exam {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Exam(
      {required this.questionText,
      required this.options,
      required this.correctAnswerIndex});

  factory Exam.fromMap(Map<String, dynamic> data) {
    return Exam(
      questionText: data['question'] ?? '',
      options: data['choices'][0] is int || data['choices'][0] is double
          ? List<String>.from(
              data['choices'].map((choice) => choice.toString()))
          : List<String>.from(data['choices']),
      correctAnswerIndex: data['correctAnswer'] ?? 0,
    );
  }
}
