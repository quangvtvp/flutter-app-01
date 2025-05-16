import 'package:flutter/material.dart';
import 'package:flutter_application/exercise/adding%20state/quiz_pageview_from_supabase.dart';
import 'package:flutter_application/exercise/adding%20state/quiz_pageview_fromjson.dart';
import 'package:flutter_application/samples/supabase_functions/model/exam_detail.dart';
import 'package:flutter_application/samples/supabase_functions/model/exam_summary.dart';
import 'package:flutter_application/samples/supabase_functions/model/question.dart';
import 'package:flutter_application/samples/supabase_functions/model/subject.dart';
import 'package:flutter_application/samples/supabase_functions/supabase_service.dart';

// Choose service type here
final IQuizDataService dataService = QuizQueryService();

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subjects')),
      body: FutureBuilder(
        future: dataService.getSubjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError)
            return Center(child: Text(snapshot.error.toString()));

          final subjects = snapshot.data as List<Subject>;
          return ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (_, index) {
              final subject = subjects[index];
              return ListTile(
                title: Text(subject.name),
                subtitle: Text('Total exams: ${subject.totalExams}'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExamListScreen(
                        subjectId: subject.id, subjectName: subject.name),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ExamListScreen extends StatelessWidget {
  final int subjectId;
  final String subjectName;
  const ExamListScreen(
      {super.key, required this.subjectId, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exams - $subjectName')),
      body: FutureBuilder(
        future: dataService.getExams(subjectId),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError)
            return Center(child: Text(snapshot.error.toString()));

          final exams = (snapshot.data as List<ExamSummary>).toList();
          return ListView.builder(
            itemCount: exams.length,
            itemBuilder: (_, index) {
              final exam = exams[index];
              return ListTile(
                title: Text(exam.title),
                subtitle: Text('${exam.totalQuestions} questions'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizTakePage(
                      examId: exam.id,
                      dataService: dataService,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ExamDetailScreen extends StatelessWidget {
  final int examId;
  final String title;
  const ExamDetailScreen(
      {super.key, required this.examId, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder(
        future: dataService.getExamDetail(examId),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError)
            return Center(child: Text(snapshot.error.toString()));

          final exam = snapshot.data as ExamDetail;
          final questions = exam.questions;

          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (_, index) {
              final q = questions[index];
              return ListTile(
                title: Text('Q${index + 1}: ${q.content}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate((q.options).length, (i) {
                    final opt = q.options[i];
                    return Text('- ${opt.content}');
                  }),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
