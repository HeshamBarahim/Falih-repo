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
      options: List<String>.from(data['choices']),
      correctAnswerIndex: data['correctAnswer'] ?? 0,
    );
  }
}
