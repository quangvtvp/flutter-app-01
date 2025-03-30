import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/exercise/adding%20state/quiz_pageview.dart';
import 'package:flutter_application/exercise/adding%20state/quiz_with_data.dart';
import 'package:flutter_application/exercise/adding%20state/single_choice.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Screen'),
      ),
      body: FutureBuilder<List<Question>>(
        future: loadQuestions(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyQuizPageview(questions: snapshot.data!);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Future<List<Question>> loadQuestions() async {
    String data = await rootBundle.loadString('assets/quiz.json');
    List<dynamic> json = jsonDecode(data);
    return json.map((element) {
      return Question.fromJson(element);
    }).toList();
  }
}
