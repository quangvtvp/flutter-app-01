import 'package:flutter/material.dart';
import 'package:flutter_application/samples/supabase_functions/model/exam_detail.dart';
import 'package:flutter_application/samples/supabase_functions/model/submitted_answer.dart';
import 'package:flutter_application/samples/supabase_functions/supabase_service.dart';

class QuizTakePage extends StatefulWidget {
  final ExamDetail examDetail;
  final IQuizDataService dataService;

  const QuizTakePage(
      {super.key, required this.examDetail, required this.dataService});

  @override
  State<QuizTakePage> createState() => _QuizTakePageState();
}

class _QuizTakePageState extends State<QuizTakePage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late List<int> _selectedAnswers; // stores index of selected options

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _selectedAnswers = List<int>.filled(widget.examDetail.questions.length, -1);
  }

  void _submitQuiz() async {
    final answers = <SubmittedAnswer>[];
    for (int i = 0; i < widget.examDetail.questions.length; i++) {
      final selectedIndex = _selectedAnswers[i];
      if (selectedIndex != -1) {
        final question = widget.examDetail.questions[i];
        final selectedOptionId = question.options[selectedIndex].id;
        answers.add(SubmittedAnswer(
            questionId: question.id, selectedOptionId: selectedOptionId));
      }
    }

    final (score, results) =
        await widget.dataService.submitExam(widget.examDetail.id, answers);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Kết quả'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Điểm: $score / ${widget.examDetail.questions.length}'),
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.examDetail.title)),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.examDetail.questions.length,
              itemBuilder: (context, index) {
                final question = widget.examDetail.questions[index];
                final selected = _selectedAnswers[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Câu ${index + 1}: ${question.content}',
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 12),
                      ...List.generate(question.options.length, (i) {
                        return RadioListTile<int>(
                          title: Text(question.options[i].content),
                          value: i,
                          groupValue: selected,
                          onChanged: (value) {
                            setState(() {
                              _selectedAnswers[index] = value!;
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
  }
}
