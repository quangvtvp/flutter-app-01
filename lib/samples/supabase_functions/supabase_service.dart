import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_application/samples/supabase_functions/model/exam_detail.dart';
import 'package:flutter_application/samples/supabase_functions/model/exam_result_summary.dart';
import 'package:flutter_application/samples/supabase_functions/model/exam_summary.dart';
import 'package:flutter_application/samples/supabase_functions/model/leaderboard_entry.dart';
import 'package:flutter_application/samples/supabase_functions/model/option.dart';
import 'package:flutter_application/samples/supabase_functions/model/question.dart';
import 'package:flutter_application/samples/supabase_functions/model/question_result.dart';
import 'package:flutter_application/samples/supabase_functions/model/stats.dart';
import 'package:flutter_application/samples/supabase_functions/model/subject.dart';
import 'package:flutter_application/samples/supabase_functions/model/submitted_answer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

// Interface for quiz services
abstract class IQuizDataService {
  Future<List<Subject>> getSubjects();
  Future<List<ExamSummary>> getExams(int subjectId);
  Future<ExamDetail> getExamDetail(int examId);
  Future<List<LeaderBoardEntry>> getLeaderBoard();
  Future<List<ExamResultSummary>> getExamHistory();
  Future<ExamDetail> getExamHistoryDetail(int examAttemptId);
  Future<(int score, List<QuestionResult> results)> submitExam(
      int examId, List<SubmittedAnswer> answers);
  Future<StatsInfo> getStatsInfo();
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

  @override
  Future<List<LeaderBoardEntry>> getLeaderBoard() async {
    final result = await client.rpc('top_user_scores_with_name').select();

    return (result as List)
        .map<LeaderBoardEntry>((r) => LeaderBoardEntry(
              user: r['name'] ?? r['user_id'].toString(),
              score: r['total_score'] ?? 0,
            ))
        .toList();
  }

  @override
  Future<List<ExamResultSummary>> getExamHistory() async {
    final user = client.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final rows = await client
        .from('exam_attempts')
        .select('id, exam_id, score, exams (title)')
        .eq('user_id', user.id)
        .order('id', ascending: false)
        .limit(10);

    return rows
        .map<ExamResultSummary>((r) => ExamResultSummary(
              id: r['id'],
              title: r['exams']['title'],
              score: r['score'] ?? 0,
            ))
        .toList();
  }

  @override
  Future<ExamDetail> getExamHistoryDetail(int examAttemptId) async {
    final attempt = await client
        .from('exam_attempts')
        .select('exam_id')
        .eq('id', examAttemptId)
        .single();

    final examId = attempt['exam_id'];
    return getExamDetail(examId);
  }

  @override
  Future<(int score, List<QuestionResult> results)> submitExam(
      int examId, List<SubmittedAnswer> answers) async {
    final user = client.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final questionIds = answers.map((a) => a.questionId).toList();

    final corrects = await client
        .from('questions')
        .select('id, correct_option_id')
        .inFilter('id', questionIds);

    final correctMap = {
      for (var q in corrects) q['id']: q['correct_option_id']
    };

    int score = 0;
    final resultList = <QuestionResult>[];

    for (final a in answers) {
      final correct = correctMap[a.questionId];
      final isCorrect = a.selectedOptionId == correct;
      if (isCorrect) score++;
      resultList.add(QuestionResult(
        questionId: a.questionId,
        isCorrect: isCorrect,
        selectedOptionId: a.selectedOptionId,
        correctOptionId: correct,
      ));
    }

    final attemptInsert = await client
        .from('exam_attempts')
        .insert({
          'user_id': user.id,
          'exam_id': examId,
          'score': score,
        })
        .select()
        .single();

    final attemptId = attemptInsert['id'];

    await client.from('answers').insert([
      for (final r in resultList)
        {
          'attempt_id': attemptId,
          'question_id': r.questionId,
          'selected_option_id': r.selectedOptionId,
          'is_correct': r.isCorrect,
        }
    ]);

    return (score, resultList);
  }

  Future<StatsInfo> getStatsInfo() async {
    final user = client.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    // 1. average score by subject
    final List<dynamic> subjectAvgQuery = await client
        .from('exam_attempts')
        .select('score, exams (subject_id, subjects (name))')
        .eq('user_id', user.id);

    final Map<String, List<int>> subjectScores = {};
    for (final Map<String, dynamic> row in subjectAvgQuery) {
      final int score = row['score'] ?? 0;
      final String subjectName = row['exams']['subjects']['name'];
      subjectScores.putIfAbsent(subjectName, () => []).add(score);
    }

    final List<SubjectAverage> subjectAverages = subjectScores.entries
        .map((e) => SubjectAverage(
              subject: e.key,
              avgScore:
                  e.value.reduce((a, b) => a + b) / e.value.length.toDouble(),
            ))
        .toList();

    // 2. correct / wrong ratio
    final List<dynamic> attemptIds =
        await client.from('exam_attempts').select('id').eq('user_id', user.id);

    final List<int> attemptIdList =
        attemptIds.map<int>((e) => e['id'] as int).toList();

    final List<dynamic> answerRows = await client
        .from('answers')
        .select('is_correct')
        .inFilter('attempt_id', attemptIdList);

    final int total = answerRows.length;
    final int correct = answerRows.where((a) => a['is_correct'] == true).length;
    final int wrong = total - correct;
    final AnswerRatio answerRatio = AnswerRatio(
      total: total,
      correct: correct,
      wrong: wrong,
      correctRate: total == 0 ? 0 : correct / total,
    );

    // 3. total score per week (past 6 weeks)
    final DateTime now = DateTime.now();
    final DateTime start = now.subtract(const Duration(days: 7 * 6));

    final List<dynamic> weeklyRaw = await client
        .from('exam_attempts')
        .select('score, created_at')
        .gte('created_at', start.toIso8601String())
        .eq('user_id', user.id);

    final Map<String, int> weekMap = <String, int>{};
    for (int i = 0; i < 6; i++) {
      final DateTime monday =
          now.subtract(Duration(days: now.weekday - 1 + 7 * i));
      final String label = DateFormat('MMM d').format(monday);
      weekMap[label] = 0;
    }

    for (final Map<String, dynamic> row in weeklyRaw) {
      final int score = row['score'] ?? 0;
      final DateTime date = DateTime.parse(row['created_at']);
      final DateTime weekStart =
          date.subtract(Duration(days: date.weekday - 1));
      final String label = DateFormat('MMM d').format(weekStart);
      if (weekMap.containsKey(label)) {
        weekMap[label] = (weekMap[label] ?? 0) + score;
      }
    }

    final List<WeeklyTotalScore> weeklyScores = weekMap.entries
        .map((e) => WeeklyTotalScore(weekLabel: e.key, totalScore: e.value))
        .toList();

    return StatsInfo(
      subjectAverages: subjectAverages,
      answerRatio: answerRatio,
      weeklyScores: weeklyScores,
    );
  }

  Future<void> insertQuizFromJson(String assetPath) async {
    final String jsonString = await rootBundle.loadString(assetPath);
    final Map<String, dynamic> quiz =
        json.decode(jsonString) as Map<String, dynamic>;

    final String subjectName = quiz['subject'] as String;
    final String examTitle = quiz['title'] as String;
    final int duration = quiz['duration_minutes'] as int;
    final List<dynamic> questions = quiz['questions'] as List<dynamic>;

    final Map<String, dynamic>? subjectRes = await client
        .from('subjects')
        .select()
        .eq('name', subjectName)
        .maybeSingle();

    final int subjectId = subjectRes != null
        ? subjectRes['id'] as int
        : (await client
            .from('subjects')
            .insert({'name': subjectName})
            .select()
            .single())['id'] as int;

    final Map<String, dynamic> examInsert = await client
        .from('exams')
        .insert({
          'title': examTitle,
          'duration_minutes': duration,
          'attempt_count': 0,
          'subject_id': subjectId,
        })
        .select()
        .single();
    final int examId = examInsert['id'] as int;

    for (final Map<String, dynamic> question
        in questions.cast<Map<String, dynamic>>()) {
      final String questionContent = question['content'] as String;
      final String correctAnswer = question['correct_answer'] as String;
      final List<String> options = question['options'] as List<String>;

      final Map<String, dynamic> insertedQuestion = await client
          .from('questions')
          .insert({'content': questionContent})
          .select()
          .single();
      final int questionId = insertedQuestion['id'] as int;

      final List<Map<String, dynamic>> optionRecords = options
          .cast<String>()
          .map((String content) => {
                'question_id': questionId,
                'content': content,
              })
          .toList();

      final List<dynamic> insertedOptions =
          await client.from('options').insert(optionRecords).select();

      final Map<String, dynamic> correctOption = insertedOptions
          .cast<Map<String, dynamic>>()
          .firstWhere((opt) => opt['content'] == correctAnswer);

      await client.from('questions').update({
        'correct_option_id': correctOption['id'] as int,
      }).eq('id', questionId);

      await client.from('exam_questions').insert({
        'exam_id': examId,
        'question_id': questionId,
      });
    }
  }
}
