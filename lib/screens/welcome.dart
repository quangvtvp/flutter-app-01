import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int _currentScreen = 0;
  int _score = 0;
  int _questionIndex = 0;

  final List<Map<String, Object>> _questions = [
    {
      "question": "Choose the correct answer: What is 2 + 2?",
      "answers": ["3", "4", "5"],
      "correct": "4",
    },
    {
      "question": "Choose the correct answer: What is the capital of France?",
      "answers": ["Berlin", "Madrid", "Paris"],
      "correct": "Paris",
    },
    {
      "question": "Choose the correct answer: What is the largest planet?",
      "answers": ["Earth", "Mars", "Jupiter"],
      "correct": "Jupiter",
    },
    {
      "question": "Choose the correct answer: What is the boiling point of water?",
      "answers": ["90°C", "100°C", "110°C"],
      "correct": "100°C",
    },
    {
      "question": "Choose the correct answer: Who wrote 'Romeo and Juliet'?",
      "answers": ["Shakespeare", "Hemingway", "Tolkien"],
      "correct": "Shakespeare",
    },
  ];

  void _nextQuestion(String selectedAnswer) {
    if (selectedAnswer == _questions[_questionIndex]["correct"]) {
      _score++;
    }
    if (_questionIndex < _questions.length - 1) {
      setState(() {
        _questionIndex++;
      });
    } else {
      setState(() {
        _currentScreen = 2;
      });
    }
  }

  void _goToLeaderboard() {
    setState(() {
      _currentScreen = 3;
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentScreen = 0;
      _score = 0;
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _currentScreen == 0
            ? WelcomeScreen(onStart: () => setState(() => _currentScreen = 1))
            : _currentScreen == 1
                ? QuizScreen(
                    question: _questions[_questionIndex],
                    onAnswerSelected: _nextQuestion,
                  )
                : _currentScreen == 2
                    ? ResultScreen(score: _score, onGoToLeaderboard: _goToLeaderboard)
                    : LeaderboardScreen(onRestart: _restartQuiz, score: _score),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onStart;

  const WelcomeScreen({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            backgroundColor: Colors.orange,
          ),
          onPressed: onStart,
          child: const Text("Start Quiz", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

class QuizScreen extends StatelessWidget {
  final Map<String, Object> question;
  final Function(String) onAnswerSelected;

  const QuizScreen({super.key, required this.question, required this.onAnswerSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(question["question"] as String, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ...(question["answers"] as List<String>).map((answer) {
            return ListTile(
              leading: Radio<String>(
                value: answer,
                groupValue: null,
                onChanged: (String? value) {
                  onAnswerSelected(answer);
                },
              ),
              title: Text(answer, style: const TextStyle(fontSize: 16)),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score;
  final VoidCallback onGoToLeaderboard;

  const ResultScreen({super.key, required this.score, required this.onGoToLeaderboard});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your Score: $score/5", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: onGoToLeaderboard,
              child: const Text("View Leaderboard", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaderboardScreen extends StatelessWidget {
  final VoidCallback onRestart;
  final int score;

  const LeaderboardScreen({super.key, required this.onRestart, required this.score});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> topPlayers = [
      {
        'name': 'lisa',
        'score': '5/5',
        'avatar': 'https://images2.thanhnien.vn/zoom/686_429/528068263637045248/2023/6/4/christina-nguyen-1685865404100381670622-108-0-768-1057-crop-16858654801521967223290.jpg',
      },
      {
        'name': 'jaden',
        'score': '4/5',
        'avatar': 'https://admin.vov.gov.vn/UploadFolder/KhoTin/Images/UploadFolder/VOVVN/Images/w800/uploaded/9eqrbt2uv7o/2020_04_01/61kxYNsKe1L__AC_SY741__WKMJ.jpg',
      },
      {
        'name': 'Charlie',
        'score': '3/5',
        'avatar': 'https://tft.edu.vn/upload/2025/01/hinh-anh-gai-my-04.webp',
      },
    ];

    return Container(
      color: Colors.blueGrey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "🏆 Leaderboard 🏆",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Column(
              children: topPlayers.map((player) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(player['avatar']!),
                  ),
                  title: Text(
                    player['name']!,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  trailing: Text(
                    player['score']!,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text(
              "Your Score: $score/5",
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: onRestart,
              child: const Text("Restart Quiz", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
