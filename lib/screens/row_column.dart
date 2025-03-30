import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "Thủ đô của Việt Nam là gì?",
      "options": ["Hà Nội", "TP. Hồ Chí Minh", "Đà Nẵng", "Huế"],
      "answer": 0
    },
    {
      "question": "Sông dài nhất thế giới là gì?",
      "options": ["Amazon", "Nile", "Mekong", "Yangtze"],
      "answer": 1
    },
    {
      "question": "Ngôn ngữ lập trình phổ biến nhất?",
      "options": ["Python", "Java", "C++", "JavaScript"],
      "answer": 0
    },
    {
      "question": "Quốc gia nào có dân số đông nhất?",
      "options": ["Ấn Độ", "Trung Quốc", "Mỹ", "Indonesia"],
      "answer": 0
    },
    {
      "question": "Thành phố nào có nhiều tòa nhà chọc trời nhất?",
      "options": ["New York", "Dubai", "Hồng Kông", "Thượng Hải"],
      "answer": 2
    },
    {
      "question": "Loài động vật nào nhanh nhất?",
      "options": ["Cheetah", "Đại bàng", "Cá mập", "Ngựa"],
      "answer": 0
    },
    {
      "question": "Kim tự tháp nằm ở quốc gia nào?",
      "options": ["Peru", "Ai Cập", "Mexico", "Trung Quốc"],
      "answer": 1
    },
    {
      "question": "Ai là nhà vật lý nổi tiếng với thuyết tương đối?",
      "options": ["Newton", "Einstein", "Tesla", "Galileo"],
      "answer": 1
    },
    {
      "question": "Tháng nào có 28 hoặc 29 ngày?",
      "options": ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4"],
      "answer": 1
    },
    {
      "question": "Ngôn ngữ chính thức của Brazil?",
      "options": [
        "Tiếng Tây Ban Nha",
        "Tiếng Bồ Đào Nha",
        "Tiếng Anh",
        "Tiếng Ý"
      ],
      "answer": 1
    },
  ];

  Map<int, int> selectedAnswers = {}; // Lưu đáp án đã chọn

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trắc nghiệm - 10 câu hỏi")),
      body: PageView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Câu ${index + 1}: ${questions[index]['question']}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Column(
                  children: List.generate(
                    questions[index]['options'].length,
                    (optionIndex) {
                      bool isAnswered = selectedAnswers.containsKey(index);
                      bool isCorrectAnswer =
                          questions[index]['answer'] == optionIndex;
                      bool isUserChoice = selectedAnswers[index] == optionIndex;

                      Color buttonColor = Colors.blue; // Màu mặc định

                      if (isAnswered) {
                        if (isCorrectAnswer) {
                          buttonColor = Colors.green; // Đáp án đúng màu xanh
                        } else if (isUserChoice) {
                          buttonColor = Colors.red; // Đáp án sai màu đỏ
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: isAnswered
                                    ? null // Không cho chọn lại nếu đã chọn
                                    : () {
                                        setState(() {
                                          selectedAnswers[index] = optionIndex;
                                        });
                                      },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          buttonColor),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(double.infinity, 50)),
                                ),
                                child: Text(
                                  questions[index]['options'][optionIndex],
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
