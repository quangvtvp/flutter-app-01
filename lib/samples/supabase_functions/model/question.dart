import 'package:flutter_application/samples/supabase_functions/model/option.dart';

class Question {
  final int id;
  final String content;
  final int correctOptionId;
  final List<Option> options;

  Question({
    required this.id,
    required this.content,
    required this.correctOptionId,
    required this.options,
  });
}
