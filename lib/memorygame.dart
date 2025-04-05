import 'package:flutter/material.dart';

class MyMemmoryGame extends StatefulWidget {
  const MyMemmoryGame({super.key});

  @override
  State<MyMemmoryGame> createState() => _MyMemmoryGameState();
}

class _MyMemmoryGameState extends State<MyMemmoryGame> {
  final List<String> _characters = [
    'A',
    'A',
    'B',
    'B',
    'C',
    'C',
    'D',
    'D',
    'E',
    'E',
    'F',
    'F',
  ];
  List<int> _activeCards = [];

  late List<bool> _isFlipped;
  bool _awaiting = false;
  List<int> score = [0, 0, 0];
  int _currentPlayer = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _gameReset();
  }

  void nextPlayer() {
    setState(() {
      _currentPlayer = (_currentPlayer + 1) % 3;
    });
  }

  void _gameReset() {
    setState(() {
      _characters.shuffle();
      _isFlipped = List<bool>.filled(_characters.length, false);
      _activeCards.clear();
      _awaiting = false;
      score = [0, 0, 0];
      _currentPlayer = 0;
    });
  }

  void _onCardClick(int index) {
    if (_awaiting) {
      return;
    }
    setState(() {
      _isFlipped[index] = true;
      _activeCards.add(index);

      // kiem tra xem da co 2 card active hay chua
      if (_activeCards.length == 2) {
        int index1 = _activeCards[0];
        int index2 = _activeCards[1];
        String char1 = _characters[index1];
        String char2 = _characters[index2];
        // kiem tra xem 2 card co giong nhau hay khong
        if (char1 == char2) {
          _isFlipped[index1] = true;
          _isFlipped[index2] = true;
          score[_currentPlayer] += 1;
        } else {
          // if not, flip them back after a short delay
          _awaiting = true;
          Future.delayed(
            const Duration(seconds: 2),
            () {
              setState(() {
                _isFlipped[index1] = false;
                _isFlipped[index2] = false;
                _activeCards.clear();
                _awaiting = false;
              });
            },
          );
        }
        // reset active cards
        _activeCards.clear();
        // switch to the next player
        nextPlayer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Game'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Reset game logic can be added here
          _gameReset();
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.refresh),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Player 1: ${score[0]}"),
                Text("Player 2: ${score[1]}"),
                Text("Player 3: ${score[2]}"),
              ],
            ),
            Expanded(
              child: GridView.builder(
                itemCount: _characters.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _onCardClick(index);
                    },
                    child: Container(
                      color: _isFlipped[index] ? Colors.redAccent : Colors.grey,
                      child: Center(
                        child: Text(
                          _isFlipped[index] ? _characters[index] : '?',
                          style: TextStyle(
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
