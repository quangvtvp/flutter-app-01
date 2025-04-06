import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  final List<String> _characters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
  ];
  List<int> _activeCards = [];
  bool _awaiting = false;
  late List<bool> _isFlipped;
  List<int> score = [0, 0, 0];
  int _currentPlayer = 0;

  @override
  void initState() {
    super.initState();
    gameReset();
  }

  void nextPlayer() {
    setState(() {
      _currentPlayer = (_currentPlayer + 1) % 3;
    });
  }

  void gameReset() {
    setState(() {
      _characters.shuffle();
      _isFlipped = List<bool>.filled(_characters.length, false);
      _activeCards.clear();
      _awaiting = false;
      score = [0, 0, 0];
    });
  }

  void _onCardClick(int index) {
    if (_awaiting) {
      return;
    }
    setState(() {
      _isFlipped[index] = true;
      _activeCards.add(index);
      // kiem tra co 2 card chua
      if (_activeCards.length == 2) {
        int index1 = _activeCards[0];
        int index2 = _activeCards[1];
        String char1 = _characters[index1];
        String char2 = _characters[index2];
        // kiem tra co giong nhau khong
        if (char1 == char2) {
          _isFlipped[index1] = true;
          _isFlipped[index2] = true;
          score[_currentPlayer] += 1;
        } else {
          _awaiting = true;
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              _isFlipped[index1] = false;
              _isFlipped[index2] = false;
              _activeCards.clear();
              _awaiting = false;
            });
          });
        }
        _activeCards.clear();
        nextPlayer();
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Game',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
        child: const Icon(Icons.refresh),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "pl1: ${score[0]}",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Text(
                  "pl2: ${score[1]}",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Text(
                  "pl3: ${score[2]}",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                itemCount: _characters.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _onCardClick(index);
                    },
                    child: Container(
                      color: _isFlipped[index]
                          ? const Color.fromARGB(255, 118, 117, 117)
                          : Colors.blueGrey,
                      child: Center(
                        child: Text(
                          _isFlipped[index] ? _characters[index] : '?',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
