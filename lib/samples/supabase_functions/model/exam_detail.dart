import 'package:flutter_application/samples/supabase_functions/model/question.dart';

class ExamDetail {
  final int id;
  final String title;
  final int duration;
  final int attemptCount;
  final List<Question> questions;

  ExamDetail({
    required this.id,
    required this.title,
    required this.duration,
    required this.attemptCount,
    required this.questions,
  });

  factory ExamDetail.fromJson(Map<String, dynamic> json) => ExamDetail(
        id: json['id'],
        title: json['title'],
        duration: json['duration'],
        attemptCount: json['attemptCount'],
        questions: (json['questions'] as List)
            .map((e) => Question.fromJson(e))
            .toList(),
      );
}
