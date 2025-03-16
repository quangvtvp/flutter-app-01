import 'package:flutter/material.dart';

class SingleChoiceQuiz extends StatefulWidget {
  const SingleChoiceQuiz({super.key});

  @override
  State<SingleChoiceQuiz> createState() => _SingleChoiceQuizState();
}

class _SingleChoiceQuizState extends State<SingleChoiceQuiz> {
  int _selectedAnswerIndex = -1; // -1 means no selection
  bool _isAnswerChecked = false;
  bool _isCorrectAnswer = false;

  final Map<String, dynamic> _quizData = {
    'question': 'What is the capital of France?',
    'answers': ['London', 'Berlin', 'Paris', 'Rome'],
    'correctAnswerIndex': 2, // Paris
  };

  void _checkAnswer() {
    setState(() {
      _isAnswerChecked = true;
      _isCorrectAnswer =
          _selectedAnswerIndex == _quizData['correctAnswerIndex'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Single Choice Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _quizData['question'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...List.generate(
              _quizData['answers'].length,
              (index) => RadioListTile<int>(
                title: Text(_quizData['answers'][index]),
                value: index,
                groupValue: _selectedAnswerIndex,
                onChanged: _isAnswerChecked
                    ? null // disable radio button after checked
                    : (value) {
                        setState(() {
                          _selectedAnswerIndex = value!;
                        });
                      },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedAnswerIndex != -1 && !_isAnswerChecked
                  ? _checkAnswer
                  : null, // Disable if no answer selected or already checked
              child: Text('Check Answer'),
            ),
            if (_isAnswerChecked)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _isCorrectAnswer ? 'Correct!' : 'Incorrect!',
                  style: TextStyle(
                    color: _isCorrectAnswer ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
