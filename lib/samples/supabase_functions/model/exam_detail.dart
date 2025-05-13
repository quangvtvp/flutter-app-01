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
}
