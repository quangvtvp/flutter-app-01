import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MemoryGameApp());
}

class MemoryGameApp extends StatelessWidget {
  const MemoryGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MemoryGameScreen(),
    );
  }
}

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({Key? key}) : super(key: key);

  @override
  _MemoryGameScreenState createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  // Characters for pairs - make sure each character appears exactly twice.
  final List<String> _characters = ['A', 'A', 'B', 'B', 'C', 'C', 'D', 'D'];

  // Each card's state (whether it’s currently flipped up or permanently matched).
  late List<bool> _isFlipped;
  late List<bool> _isMatched;

  // Indices of the two currently flipped cards (if any).
  List<int> _flippedIndices = [];

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    // Shuffle characters for a fresh layout
    _characters.shuffle(Random());
    _isFlipped = List<bool>.filled(_characters.length, false);
    _isMatched = List<bool>.filled(_characters.length, false);
    _flippedIndices.clear();
    setState(() {});
  }

  void _onCardTap(int index) {
    // If already matched or currently flipped, do nothing
    if (_isMatched[index] || _isFlipped[index]) {
      return;
    }

    setState(() {
      // Flip the tapped card
      _isFlipped[index] = true;
      _flippedIndices.add(index);

      // If two cards are flipped, check match
      if (_flippedIndices.length == 2) {
        final firstIndex = _flippedIndices[0];
        final secondIndex = _flippedIndices[1];
        final firstChar = _characters[firstIndex];
        final secondChar = _characters[secondIndex];

        // If they match, mark as matched
        if (firstChar == secondChar) {
          _isMatched[firstIndex] = true;
          _isMatched[secondIndex] = true;
          _flippedIndices.clear();
        } else {
          // If they don't match, flip them back after a short delay
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              _isFlipped[firstIndex] = false;
              _isFlipped[secondIndex] = false;
              _flippedIndices.clear();
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if all cards are matched
    bool allMatched = _isMatched.every((matched) => matched);

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
      body: Center(
        child: allMatched
            ? const Text(
                'You Win!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              )
            : GridView.builder(
                // Adjust grid counts to your preference
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 columns
                  childAspectRatio: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                padding: const EdgeInsets.all(16),
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
                          // Show the character only if flipped or matched
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
    );
  }
}
