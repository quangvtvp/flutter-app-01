import 'package:flutter/material.dart';
import 'package:flutter_application/exercise/adding%20state/cards.dart';
import 'package:flutter_application/exercise/adding%20state/leader_board.dart';
import 'package:flutter_application/exercise/adding%20state/next_color.dart';
import 'package:flutter_application/exercise/adding%20state/quiz.dart';
import 'package:flutter_application/exercise/adding%20state/quiz_pageview.dart';
import 'package:flutter_application/exercise/adding%20state/quiz_with_data.dart';
import 'package:flutter_application/exercise/adding%20state/single_choice.dart';
import 'package:flutter_application/exercise/cards.dart';
import 'package:flutter_application/exercise/data/quiz.dart';
import 'package:flutter_application/exercise/grid_stock.dart';
import 'package:flutter_application/exercise/stock.dart';
import 'package:flutter_application/exercise/weather.dart';
import 'package:flutter_application/live/list_grid.dart';
import 'package:flutter_application/live/simple_state.dart';
import 'package:flutter_application/model/vocabulary.dart';

void main() {
  // runApp(const MyApp());
  // runApp(const GridStock());
  // runWeather();
  // runApp(const MaterialApp(
  //   home: Scaffold(
  //     body: MyWeather(),
  //   ),
  // ));
  runLeaderBoard();

  // final Question question = Question(
  //     text: 'What is the capital of France?',
  //     answers: [
  //       Answer(text: 'London', isCorrect: false),
  //       Answer(text: 'Berlin', isCorrect: false),
  //       Answer(text: 'Paris', isCorrect: true),
  //       Answer(text: 'Rome', isCorrect: false),
  //     ],
  //     type: 'single');
  // runApp(MaterialApp(
  //   home: Scaffold(
  //     body: MyQuizPageview(
  //       questions: questionsData,
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

void runLeaderBoard() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: MyLeaderBoard(),
    ),
  ));
}
