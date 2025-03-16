import 'package:flutter/material.dart';
import 'package:flutter_application/exercise/adding%20state/cards.dart';
import 'package:flutter_application/exercise/adding%20state/next_color.dart';
import 'package:flutter_application/exercise/adding%20state/quiz.dart';
import 'package:flutter_application/exercise/adding%20state/quiz_with_data.dart';
import 'package:flutter_application/exercise/grid_stock.dart';
import 'package:flutter_application/exercise/stock.dart';
import 'package:flutter_application/exercise/weather.dart';
import 'package:flutter_application/model/vocabulary.dart';

void main() {
  // runApp(const MyApp());
  // runApp(const GridStock());
  runWeather();
  // runApp(const MaterialApp(
  //   home: Scaffold(
  //     body: SingleChoiceQuiz(),
  //   ),
  // ));
  // // runApp(const MyListviewBuilder());

  final Question question =
      Question(text: 'What is the capital of France?', answers: [
    Answer(text: 'London', isCorrect: false),
    Answer(text: 'Berlin', isCorrect: false),
    Answer(text: 'Paris', isCorrect: true),
    Answer(text: 'Rome', isCorrect: false),
  ]);
  // runApp(MaterialApp(
  //   home: Scaffold(
  //     body: SingleChoiceQuizV2(
  //       question: question,
  //     ),
  //   ),
  // ));
  /*

  */
}

void runStock() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: SizedBox(
        height: 240,
        width: 240,
        child: MyStock(),
      ),
    ),
  ));
}

void runWeather() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: MyWeather(),
    ),
  ));
}
