import 'package:flutter/material.dart';
import 'package:flutter_application/samples/supabase_functions/model/question.dart';

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
          widget.question.content,
          style: const TextStyle(fontSize: 25),
        ),
        ...List.generate(widget.question.options.length, (index) {
          return RadioListTile<int>(
            title: Text(widget.question.options[index].content),
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
