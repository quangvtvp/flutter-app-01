import 'package:flutter/material.dart';
import 'dart:math';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  State<MemoryGameScreen> createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  // Hard-coded list of first 15 characters from the alphabet, each appearing twice.
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

  // Three players
  final List<String> _playerNames = ['Player 1', 'Player 2', 'Player 3'];
  late List<int> _scores; // Scores for each player
  int _currentPlayer = 0; // Index of the current player

  // Card states
  late List<bool> _isFlipped;
  late List<bool> _isMatched;
  List<int> _flippedIndices = [];

  // To prevent flipping more cards while waiting for a mismatch to flip back
  bool _awaitingReset = false;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  /// Sets up a fresh game:
  ///  - Shuffle the cards,
  ///  - Reset flipped/matched states,
  ///  - Reset scores and set the first player to begin.
  void _startGame() {
    _characters.shuffle(Random());
    _isFlipped = List<bool>.filled(_characters.length, false);
    _isMatched = List<bool>.filled(_characters.length, false);
    _flippedIndices.clear();
    _scores = [0, 0, 0];
    _currentPlayer = 0;
    _awaitingReset = false;

    setState(() {});
  }

  /// Moves to the next player (0 -> 1 -> 2 -> 0 -> ...)
  void _nextPlayer() {
    _currentPlayer = (_currentPlayer + 1) % 3;
  }

  void _onCardTap(int index) {
    // If we're waiting for a mismatch to reset, or if card is matched/flipped, do nothing
    if (_awaitingReset || _isMatched[index] || _isFlipped[index]) {
      return;
    }

    setState(() {
      // Flip the tapped card
      _isFlipped[index] = true;
      _flippedIndices.add(index);

      // If two cards are flipped, check for a match
      if (_flippedIndices.length == 2) {
        final firstIndex = _flippedIndices[0];
        final secondIndex = _flippedIndices[1];
        final firstChar = _characters[firstIndex];
        final secondChar = _characters[secondIndex];

        if (firstChar == secondChar) {
          // MATCH: increment current player's score
          _scores[_currentPlayer]++;
          _isMatched[firstIndex] = true;
          _isMatched[secondIndex] = true;
          _flippedIndices.clear();
          // Switch to the next player
          _nextPlayer();
        } else {
          // MISMATCH: flip them back after a short delay
          _awaitingReset = true;
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              _isFlipped[firstIndex] = false;
              _isFlipped[secondIndex] = false;
              _flippedIndices.clear();
              _awaitingReset = false;
              // Switch to the next player
              _nextPlayer();
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if all cards are matched
    final bool allMatched = _isMatched.every((matched) => matched);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Game'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _startGame,
          ),
        ],
      ),
      body: Column(
        children: [
          // Display current player and scores
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Current Player: ${_playerNames[_currentPlayer]}\n'
              '${_playerNames[0]}: ${_scores[0]} | '
              '${_playerNames[1]}: ${_scores[1]} | '
              '${_playerNames[2]}: ${_scores[2]}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),

          Expanded(
            child: Center(
              child: allMatched
                  ? const Text(
                      'Game Over!\nAll Matches Found!',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            3, // 5 columns to accommodate 30 cards (15 pairs)
                        childAspectRatio: 1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: _characters.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _onCardTap(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _isFlipped[index] || _isMatched[index]
                                  ? Colors.amber
                                  : Colors.grey[400],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                (_isFlipped[index] || _isMatched[index])
                                    ? _characters[index]
                                    : '?',
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
