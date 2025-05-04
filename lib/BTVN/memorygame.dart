// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'dart:math';

// int rowNumber(int number) {
//   int result = 0;
//   for (int i = 1; i < (sqrt(number) + 2).toInt(); i++) {
//     if (number % i == 0) {
//       result = i;
//     }
//   }
//   return result;
// }

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   List<dynamic> _character = ['1', '2', '3', '4', '5'];
//   List<int> _activeCard = [];
//   late List<bool> _isFlipped;
//   bool _awaiting = false;
//   List<int> playersScore = [0, 0];
//   int currentPlayer = 0;

//   @override
//   void initState() {
//     super.initState();
//     playersScore;
//     currentPlayer;
//     _character = _character + _character;
//     _character.shuffle();
//     _isFlipped = List<bool>.filled(_character.length, false);
//   }

//   _onCardClick(int index) {
//     if (_awaiting) {
//       return;
//     }

//     setState(() {
//       _isFlipped[index] = true;
//       if (_isFlipped[index]) {
//         _activeCard.add(index);
//       }

//       if (_activeCard.length == 2) {
//         int index1 = _activeCard[0];
//         int index2 = _activeCard[1];
//         _awaiting = true;

//         Future.delayed(Duration(seconds: 1), () {
//           if (_character[index1] != _character[index2]) {
//             setState(() {
//               _isFlipped[index1] = false;
//               _isFlipped[index2] = false;
//             });
//           } else {
//             setState(() {
//               playersScore[currentPlayer] += 1;
//             });
//           }

//           _activeCard = [];
//           currentPlayer = (currentPlayer + 1) % 2; // Chỉnh lại cho 2 người chơi
//           _awaiting = false;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           backgroundColor: Colors.white,
//           body: Column(
//             children: [
//               const _Appbar(),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(
//                     '${playersScore[0]}',
//                     style: TextStyle(
//                         fontSize: 20,
//                         color:
//                             (currentPlayer == 0) ? Colors.red : Colors.black),
//                   ),
//                   Text(
//                     '${playersScore[1]}',
//                     style: TextStyle(
//                         fontSize: 20,
//                         color:
//                             (currentPlayer == 1) ? Colors.red : Colors.black),
//                   )
//                 ],
//               ),
//               Expanded(
//                 flex: 100,
//                 child: GridView.builder(
//                     itemCount: _character.length,
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 5,
//                       crossAxisSpacing: 3,
//                       mainAxisSpacing: 3,
//                     ),
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           _onCardClick(index);
//                         },
//                         child: Container(
//                           color: Colors.blue,
//                           child: Center(
//                             child: Text(
//                               _isFlipped[index] ? _character[index] : '?',
//                               style: const TextStyle(
//                                 fontSize: 50,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//               )
//             ],
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {},
//             backgroundColor: Colors.red,
//             child: const Icon(Icons.refresh),
//           )),
//     );
//   }
// }

// class _Appbar extends StatelessWidget {
//   const _Appbar();

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//         flex: 5,
//         child: AppBar(
//           title: const Text('title',
//               style: TextStyle(fontSize: 50, color: Colors.black)),
//           centerTitle: true,
//           backgroundColor: Colors.deepOrange,
//         ));
//   }
// }
