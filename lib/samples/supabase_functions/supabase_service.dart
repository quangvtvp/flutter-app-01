import 'package:flutter_application/samples/supabase_functions/model/exam_detail.dart';
import 'package:flutter_application/samples/supabase_functions/model/exam_summary.dart';
import 'package:flutter_application/samples/supabase_functions/model/option.dart';
import 'package:flutter_application/samples/supabase_functions/model/question.dart';
import 'package:flutter_application/samples/supabase_functions/model/subject.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Interface for quiz services
abstract class IQuizDataService {
  Future<List<Subject>> getSubjects();
  Future<List<ExamSummary>> getExams(int subjectId);
  Future<ExamDetail> getExamDetail(int examId);
  Future<List<ExamSummary>> getExamsHistory();
}
// =============================
// 2. Direct query-based implementation
// =============================

class QuizQueryService implements IQuizDataService {
  final SupabaseClient client = Supabase.instance.client;

  @override
  Future<List<Subject>> getSubjects() async {
    final res = await client.from('subjects').select('id, name');
    final exams = await client.from('exams').select('id, subject_id');

    final examCountMap = <int, int>{};
    for (var exam in exams) {
      final sid = exam['subject_id'] as int;
      examCountMap[sid] = (examCountMap[sid] ?? 0) + 1;
    }

    return res
        .map<Subject>((s) => Subject(
              id: s['id'],
              name: s['name'],
              totalExams: examCountMap[s['id']] ?? 0,
            ))
        .toList();
  }

  @override
  Future<List<ExamSummary>> getExams(int subjectId) async {
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
        .map<ExamSummary>((e) => ExamSummary(
              id: e['id'],
              title: e['title'],
              duration: e['duration_minutes'],
              attemptCount: e['attempt_count'] ?? 0,
              totalQuestions: countMap[e['id']] ?? 0,
            ))
        .toList();
  }

  @override
  Future<ExamDetail> getExamDetail(int examId) async {
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

    final questionsRaw = await client
        .from('questions')
        .select('id, content, correct_option_id')
        .inFilter('id', questionIds);

    final optionsRaw = await client
        .from('options')
        .select('id, content, question_id')
        .inFilter('question_id', questionIds);

    final questions = questionsRaw.map<Question>((q) {
      final qid = q['id'];
      final opts = optionsRaw
          .where((o) => o['question_id'] == qid)
          .map<Option>((o) => Option.fromJson(o))
          .toList();
      return Question(
        id: qid,
        content: q['content'],
        correctOptionId: q['correct_option_id'],
        options: opts,
      );
    }).toList();

    return ExamDetail(
      id: exam['id'],
      title: exam['title'],
      duration: exam['duration_minutes'],
      attemptCount: exam['attempt_count'] ?? 0,
      questions: questions,
    );
  }
}
