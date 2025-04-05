import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MyMomeryGame extends StatefulWidget {
  const MyMomeryGame({super.key});

  @override
  State<MyMomeryGame> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyMomeryGame> {
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
    'G',
    'G',
    'H',
    'H',
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
    'G',
    'G',
    'H',
    'H',
  ];
  late List<bool> _isFlipped;
  final List _activeCards = [];
  bool _awaiting = false;
  List<int> _score = [0, 0, 0];
  int _currentPlayer = 0;
  late AudioCache _audioCache;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioCache = AudioCache(prefix: 'assets/sound/');
    _gameReset();
  }

  void _onFlipcard(int index) {
    if (_isFlipped[index] || _awaiting) {
      return;
    }

    setState(() {
      _isFlipped[index] = true;
      _activeCards.add(index);

      // if there are 2 active cards then compare them
      if (_activeCards.length == 2) {
        int index1 = _activeCards[0];
        int index2 = _activeCards[1];
        String char1 = _characters[index1];
        String char2 = _characters[index2];
        // check if the cards match
        if (char1 == char2) {
          // flip the cards
          _isFlipped[index1] = true;
          _isFlipped[index2] = true;
          _score[_currentPlayer] += 1;
          if (_isFlipped.every((flipped) => flipped)) {
            _audioCache.play('win.wav');
          } else {
            _audioCache.play('tick.wav');
          }
        } else {
          // flip the cards back
          _awaiting = true;
          _audioCache.play('incorrect.wav');
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
        _nextPlayer();
      }
    });
  }

  void _gameReset() {
    _characters.shuffle();
    _isFlipped = List<bool>.filled(_characters.length, false);
    _activeCards.clear();
    _score = [0, 0, 0];
    _currentPlayer = 0;
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = const TextStyle(fontSize: 20);
    const boldTextStyle =
        const TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Memory Game'),
            backgroundColor: Colors.redAccent,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                _gameReset();
              });
            },
            backgroundColor: Colors.redAccent,
            child: const Icon(Icons.refresh),
          ),
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Player 1 - Junho: ${_score[0]}",
                      style: _currentPlayer == 0 ? boldTextStyle : textStyle),
                  Text("Player 2 - Hue: ${_score[1]}",
                      style: _currentPlayer == 1 ? boldTextStyle : textStyle),
                  Text("Player 3 - Quang: ${_score[2]}",
                      style: _currentPlayer == 2 ? boldTextStyle : textStyle),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: _characters.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 9,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _onFlipcard(index);
                    },
                    child: Card(
                      color: _isFlipped[index] ? Colors.redAccent : Colors.grey,
                      child: Center(
                        child: Text(
                          _isFlipped[index] ? _characters[index] : "?",
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ])),
    );
  }

  void _nextPlayer() {
    _currentPlayer = (_currentPlayer + 1) % 3;
  }
}
