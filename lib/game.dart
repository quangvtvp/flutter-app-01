import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(CatchTheSquareGame());
}

class CatchTheSquareGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catch the Square',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/game': (context) => GameScreen(),
      },
    );
  }
}

// Màn hình chào mừng
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catch the Square'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Catch the Square',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, '/game'); // Chuyển đến màn hình trò chơi
              },
              child: Text(
                'Start',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Màn hình trò chơi
class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Vị trí ngẫu nhiên của hình vuông
  double squareX = 0;
  double squareY = 0;

  // Điểm số
  int score = 0;

  // Biến để kiểm tra trạng thái game over
  bool isGameOver = false;

  // Timer để đếm ngược 2 giây
  Timer? timer;

  // Phương thức để tạo vị trí ngẫu nhiên
  void randomizeSquarePosition(Size screenSize) {
    final random = Random();
    setState(() {
      squareX = random.nextDouble() * (screenSize.width - 100);
      squareY = random.nextDouble() * (screenSize.height - 200);
    });
  }

  // Bắt đầu đếm ngược 2 giây
  void startTimer() {
    timer?.cancel(); // Hủy timer cũ nếu có
    timer = Timer(Duration(seconds: 2), () {
      setState(() {
        isGameOver = true; // Kết thúc trò chơi nếu không bấm kịp
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Không khởi tạo ở đây vì MediaQuery chưa sẵn sàng
  }

  @override
  void dispose() {
    timer?.cancel(); // Hủy timer khi widget bị hủy
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình
    final screenSize = MediaQuery.of(context).size;

    // Gọi hàm randomizeSquarePosition trong build()
    if (squareX == 0 && squareY == 0) {
      randomizeSquarePosition(screenSize);
      startTimer(); // Bắt đầu đếm ngược
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Catch the Square'),
      ),
      body: Stack(
        children: [
          if (!isGameOver)
            Positioned(
              left: squareX,
              top: squareY,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    score++; // Tăng điểm khi nhấp vào hình vuông
                    randomizeSquarePosition(
                        screenSize); // Di chuyển hình vuông đến vị trí mới
                    startTimer(); // Khởi động lại timer
                  });
                },
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Tap!',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          if (isGameOver)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Game Over!',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Your Score: $score',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        score = 0; // Reset điểm số
                        isGameOver = false; // Reset trạng thái game over
                        randomizeSquarePosition(
                            screenSize); // Đặt lại vị trí ban đầu
                        startTimer(); // Khởi động lại timer
                      });
                    },
                    child: Text('Restart'),
                  ),
                ],
              ),
            ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              'Score: $score',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
