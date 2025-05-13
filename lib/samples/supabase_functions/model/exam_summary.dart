class ExamSummary {
  final int id;
  final String title;
  final int duration;
  final int attemptCount;
  final int totalQuestions;

  ExamSummary({
    required this.id,
    required this.title,
    required this.duration,
    required this.attemptCount,
    required this.totalQuestions,
  });

  factory ExamSummary.fromJson(Map<String, dynamic> json) => ExamSummary(
        id: json['id'],
        title: json['title'],
        duration: json['duration_minutes'],
        attemptCount: json['attempt_count'] ?? 0,
        totalQuestions: json['total_questions'] ?? 0,
      );
}
