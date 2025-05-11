import 'package:supabase_flutter/supabase_flutter.dart';

// Defines a shared interface for quiz data services
abstract class IQuizDataService {
  Future<List<dynamic>> getSubjects();
  Future<List<dynamic>> getExams(int subjectId);
  Future<Map<String, dynamic>> getExamDetail(int examId);
}

// =============================
// 1. Function-based implementation
// =============================

class QuizFunctionService implements IQuizDataService {
  final SupabaseClient client = Supabase.instance.client;

  @override
  Future<List<dynamic>> getSubjects() async {
    final response =
        await Supabase.instance.client.functions.invoke('get_subjects');
    if (response.status == 200) return response.data as List<dynamic>;
    throw Exception('Failed to fetch subjects: ${response.data}');
  }

  @override
  Future<List<dynamic>> getExams(int subjectId) async {
    final response = await client.functions.invoke(
      'get_exam',
      queryParameters: {'id': subjectId.toString()},
    );
    if (response.status == 200) return response.data as List<dynamic>;
    throw Exception('Failed to fetch exams: ${response.data}');
  }

  @override
  Future<Map<String, dynamic>> getExamDetail(int examId) async {
    final response = await client.functions.invoke(
      'get_exam_detail',
      queryParameters: {'id': examId.toString()},
    );
    if (response.status == 200) return response.data as Map<String, dynamic>;
    throw Exception('Failed to fetch exam detail: ${response.data}');
  }
}

// =============================
// 2. Direct query-based implementation
// =============================
class QuizQueryService implements IQuizDataService {
  final SupabaseClient client = Supabase.instance.client;

  @override
  Future<List<dynamic>> getSubjects() async {
    final res = await client.from('subjects').select('id, name');
    final exams = await client.from('exams').select('id, subject_id');

    final examCountMap = <int, int>{};
    for (var exam in exams) {
      final sid = exam['subject_id'] as int;
      examCountMap[sid] = (examCountMap[sid] ?? 0) + 1;
    }

    return res
        .map((s) => {...s, 'total_exams': examCountMap[s['id']] ?? 0})
        .toList();
  }

  @override
  Future<List<dynamic>> getExams(int subjectId) async {
    final exams = await client
        .from('exams')
        .select('id, title, duration_minutes, attempt_count, subject_id')
        .eq('subject_id', subjectId);

    final links = await client.from('exam_questions').select('exam_id');

    final countMap = <int, int>{};
    for (var q in links) {
      final id = q['exam_id'] as int;
      countMap[id] = (countMap[id] ?? 0) + 1;
    }

    return exams
        .map((e) => {...e, 'total_questions': countMap[e['id']] ?? 0})
        .toList();
  }

  @override
  Future<Map<String, dynamic>> getExamDetail(int examId) async {
    final exam = await client
        .from('exams')
        .select('id, title, duration_minutes, attempt_count')
        .eq('id', examId)
        .single();

    final questionLinks = await client
        .from('exam_questions')
        .select('question_id')
        .eq('exam_id', examId);

    final questionIds =
        questionLinks.map((q) => q['question_id'] as int).toList();

    final questions = await client
        .from('questions')
        .select('id, content, correct_option_id')
        .inFilter('id', questionIds);

    final options = await client
        .from('options')
        .select('id, content, question_id')
        .inFilter('question_id', questionIds);

    final formattedQuestions = questions
        .map((q) => {
              'question_id': q['id'],
              'content': q['content'],
              'correct_option_id': q['correct_option_id'],
              'options':
                  options.where((o) => o['question_id'] == q['id']).toList()
            })
        .toList();

    return {
      ...exam,
      'total_questions': formattedQuestions.length,
      'questions': formattedQuestions
    };
  }
}
