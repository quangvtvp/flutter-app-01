import 'package:flutter/material.dart';

class Answer {
  final String text;
  final bool isCorrect;

  Answer({required this.text, required this.isCorrect});
}

class Question {
  final String text;
  final List<Answer> answers;
  final String type; // single or multiple, better to be an enum
  List<int> selectedAnswerIndex = [];
  Question({required this.text, required this.answers, required this.type});
}

class SingleChoiceQuizV2 extends StatefulWidget {
  final Question question;

  SingleChoiceQuizV2({required this.question});

  @override
  State<SingleChoiceQuizV2> createState() => _SingleChoiceQuizState();
}

class _SingleChoiceQuizState extends State<SingleChoiceQuizV2> {
  int _selectedAnswerIndex = -1;
  bool _isAnswerChecked = false;
  bool _isCorrectAnswer = false;

  void _checkAnswer() {
    setState(() {
      _isAnswerChecked = true;
      if (_selectedAnswerIndex != -1) {
        _isCorrectAnswer =
            widget.question.answers[_selectedAnswerIndex].isCorrect;
      } else {
        _isCorrectAnswer = false;
      }
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
              widget.question.text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...List.generate(
              widget.question.answers.length,
              (index) => RadioListTile<int>(
                title: Text(widget.question.answers[index].text),
                value: index,
                groupValue: _selectedAnswerIndex,
                onChanged: _isAnswerChecked
                    ? null
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
                  : null,
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
