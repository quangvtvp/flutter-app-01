import 'package:flutter/material.dart';
import 'package:flutter_application/exercise/adding%20state/quiz_with_data.dart';

class MySingleChoiceQuiz extends StatefulWidget {
  final Question question;
  const MySingleChoiceQuiz({super.key, required this.question});

  @override
  State<MySingleChoiceQuiz> createState() => _MySingleChoiceQuizState();
}

class _MySingleChoiceQuizState extends State<MySingleChoiceQuiz> {
  int _selectedAnswerIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Text(
          widget.question.text,
          style: const TextStyle(fontSize: 25),
        ),
        ...List.generate(widget.question.answers.length, (index) {
          return RadioListTile<int>(
            title: Text(widget.question.answers[index].text),
            value: index,
            groupValue: _selectedAnswerIndex,
            onChanged: (value) {
              setState(() {
                _selectedAnswerIndex = value!;
              });
            },
          );
        }),
      ]),
    );
  }
}
