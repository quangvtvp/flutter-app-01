class QuestionResult {
  final int questionId;
  final bool isCorrect;
  final int selectedOptionId;
  final int correctOptionId;

  QuestionResult({
    required this.questionId,
    required this.isCorrect,
    required this.selectedOptionId,
    required this.correctOptionId,
  });
}
