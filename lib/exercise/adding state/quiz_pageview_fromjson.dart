import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/samples/supabase_functions/model/exam_detail.dart';
import 'package:flutter_application/samples/supabase_functions/model/submitted_answer.dart';
import 'package:flutter_application/samples/supabase_functions/supabase_service.dart';

void main(List<String> args) {
  runApp(const MaterialApp(
    home: QuizTakePage(
      examId: 1,
    ),
  ));
}

class QuizTakePage extends StatefulWidget {
  final int examId;
  const QuizTakePage({super.key, required this.examId});

  @override
  State<QuizTakePage> createState() => _QuizTakePageState();
}

class _QuizTakePageState extends State<QuizTakePage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  List<int>? _selectedAnswers;
  late Future<ExamDetail> _examFuture;
  ExamDetail? _examDetail;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _examFuture = QuizQueryService().getExamDetail(widget.examId);
  }

  Future<ExamDetail> readExamFromJson(int examId) async {
    final jsonString = await rootBundle.loadString("assets/quiz.json");
    final jsonMap = json.decode(jsonString);
    return ExamDetail.fromJson(jsonMap);
  }

  void _submitQuiz() async {
    if (_examDetail == null || _selectedAnswers == null) return;

    final answers = <SubmittedAnswer>[];
    for (int i = 0; i < _examDetail!.questions.length; i++) {
      final selectedIndex = _selectedAnswers![i];
      if (selectedIndex != -1) {
        final question = _examDetail!.questions[i];
        final selectedOptionId = question.options[selectedIndex].id;
        answers.add(SubmittedAnswer(
            questionId: question.id, selectedOptionId: selectedOptionId));
      }
    }

    final (score, results) =
        await QuizQueryService().submitExam(_examDetail!.id, answers);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Kết quả'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Điểm: $score / ${_examDetail!.questions.length}'),
            const SizedBox(height: 16),
            ...results.map((r) => ListTile(
                  title: Text('Câu hỏi ${r.questionId}'),
                  subtitle: Text(r.isCorrect ? 'Đúng' : 'Sai'),
                ))
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('OK'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ExamDetail>(
      future: _examFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Quiz')),
            body: Center(child: Text('Lỗi: ${snapshot.error}')),
          );
        }
        _examDetail = snapshot.data!;
        _selectedAnswers ??=
            List<int>.filled(_examDetail!.questions.length, -1);

        return Scaffold(
          appBar: AppBar(title: Text(_examDetail!.title)),
          body: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _examDetail!.questions.length,
                  itemBuilder: (context, index) {
                    final question = _examDetail!.questions[index];
                    final selected = _selectedAnswers![index];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Câu ${index + 1}: ${question.content}',
                              style: const TextStyle(fontSize: 20)),
                          const SizedBox(height: 12),
                          ...List.generate(question.options.length, (i) {
                            final optionId = question.options[i].id;
                            return RadioListTile<int>(
                              title: Text(question.options[i].content),
                              value: optionId,
                              groupValue: selected != -1
                                  ? question.options[selected].id
                                  : null,
                              onChanged: (value) {
                                setState(() {
                                  _selectedAnswers![index] = question.options
                                      .indexWhere((o) => o.id == value);
                                });
                              },
                            );
                          })
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                    child: const Text('Trước'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                    child: const Text('Tiếp'),
                  ),
                  ElevatedButton(
                    onPressed: _submitQuiz,
                    child: const Text('Nộp bài'),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
