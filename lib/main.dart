import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/exercise/adding%20state/cards.dart';
import 'package:flutter_application/exercise/adding%20state/leader_board.dart';
import 'package:flutter_application/exercise/adding%20state/next_color.dart';
import 'package:flutter_application/exercise/adding%20state/quiz.dart';
import 'package:flutter_application/exercise/adding%20state/quiz_pageview.dart';
import 'package:flutter_application/exercise/adding%20state/quiz_pageview_fromjson.dart';
import 'package:flutter_application/exercise/adding%20state/quiz_with_data.dart';
import 'package:flutter_application/exercise/adding%20state/single_choice.dart';
import 'package:flutter_application/exercise/adding%20state/todo.dart';
import 'package:flutter_application/exercise/cards.dart';
import 'package:flutter_application/exercise/data/quiz.dart';
import 'package:flutter_application/exercise/grid_stock.dart';
import 'package:flutter_application/exercise/stock.dart';
import 'package:flutter_application/exercise/weather.dart';
import 'package:flutter_application/json/jsonparse.dart';
import 'package:flutter_application/live/list_grid.dart';
import 'package:flutter_application/live/simple_state.dart';
import 'package:flutter_application/model/vocabulary.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   String data = await rootBundle.loadString('assets/screen.json');
//   print(data);
//   Map<String, dynamic> json = jsonDecode(data);

//   String title = json['title'];
//   List<dynamic> items = json['leaderboard'] as List;
//   List<ListTile> listPlayers = items.map((e) {
//     return ListTile(
//       title: Text(e['name']),
//       subtitle: Text(e['score'].toString()),
//     );
//   }).toList();
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Container(
//         child: ListView(
//           children: listPlayers,
//         ),
//       ),
//     ),
//   ));
// }

void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuizScreen()));
            },
            child: Text("Take a quiz"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TodoApp()));
            },
            child: Text("Go to TODO List"),
          ),
        ],
      ),
    );
  }
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
