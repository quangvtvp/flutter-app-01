import 'package:flutter/material.dart';
import 'package:flutter_application/samples/supabase_functions/supabase_service.dart';

// Choose service type here
final IQuizDataService dataService =
    QuizFunctionService(); // or QuizQueryService()

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

          final subjects = snapshot.data as List<dynamic>;
          return ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (_, index) {
              final subject = subjects[index];
              return ListTile(
                title: Text(subject['name']),
                subtitle: Text('Total exams: ${subject['total_exams']}'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExamListScreen(
                        subjectId: subject['id'], subjectName: subject['name']),
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

          final exams = (snapshot.data as List).toList();
          return ListView.builder(
            itemCount: exams.length,
            itemBuilder: (_, index) {
              final exam = exams[index];
              return ListTile(
                title: Text(exam['title']),
                subtitle: Text('${exam['total_questions']} questions'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExamDetailScreen(
                        examId: exam['id'], title: exam['title']),
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

          final exam = snapshot.data as Map<String, dynamic>;
          final questions = exam['questions'] as List<dynamic>;

          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (_, index) {
              final q = questions[index];
              return ListTile(
                title: Text('Q${index + 1}: ${q['content']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate((q['options'] as List).length, (i) {
                    final opt = q['options'][i];
                    return Text('- ${opt['content']}');
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
