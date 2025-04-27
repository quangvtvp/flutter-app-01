import 'package:flutter/material.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: MyHoa(),
//   ));
// }

class MyHoa extends StatefulWidget {
  const MyHoa({super.key});

  @override
  State<MyHoa> createState() => _MychoicePageViewState();
}

class _MychoicePageViewState extends State<MyHoa> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Question> questions = [
    Question(
      question: "What is the capital of France?",
      options: ["London", "Berlin", "Paris", "Rome"],
      correctAnswer: "paris",
    ),
    Question(
      question: "Which planet is known as the Red Planet?",
      options: ["Venus", "Mars", "Jupiter", "Saturn"],
      correctAnswer: "Mars",
    ),
  ];

  void _nextQuestion() {
    if (_currentPage < questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      setState(() {});
    }
  }

  void _prevQuestion() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return QuestionCard(
                  question: questions[index],
                  onNextQuestion: _nextQuestion,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentPage > 0)
                ElevatedButton(
                  onPressed: _prevQuestion,
                  child: const Text("Back"),
                ),
              ElevatedButton(
                onPressed: _nextQuestion,
                child: const Text("Next"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;
  String? selectedOption;
  bool isChecked = false;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

class QuestionCard extends StatefulWidget {
  final Question question;
  final VoidCallback onNextQuestion;

  const QuestionCard({
    super.key,
    required this.question,
    required this.onNextQuestion,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  void _checkAnswer(String selectedOption) {
    setState(() {
      widget.question.selectedOption = selectedOption;
      widget.question.isChecked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.question.question,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: widget.question.options.map((option) {
                  Color textColor = Colors.black;

                  if (widget.question.isChecked) {
                    if (option == widget.question.correctAnswer) {
                      textColor = Colors.green;
                    } else if (option == widget.question.selectedOption) {
                      textColor = Colors.red;
                    }
                  }

                  return ListTile(
                    title: Text(
                      option,
                      style: TextStyle(
                        fontSize: 20,
                        color: textColor,
                      ),
                    ),
                    leading: Radio<String>(
                      value: option,
                      groupValue: widget.question.selectedOption,
                      onChanged: widget.question.isChecked
                          ? null
                          : (value) {
                              _checkAnswer(value!);
                            },
                    ),
                  );
                }).toList(),
              ),
              if (widget.question.isChecked)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: widget.question.selectedOption ==
                              widget.question.correctAnswer
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
              // const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
