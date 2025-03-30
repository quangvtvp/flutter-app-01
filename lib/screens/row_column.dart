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
    {"question": "Thủ đô của Việt Nam là gì?", "options": ["Hà Nội", "TP. Hồ Chí Minh", "Đà Nẵng", "Huế"], "answer": "Hà Nội"},
    {"question": "Sông dài nhất thế giới là gì?", "options": ["Amazon", "Nile", "Mekong", "Yangtze"], "answer": "Nile"},
    {"question": "Ngôn ngữ lập trình phổ biến nhất?", "options": ["Python", "Java", "C++", "JavaScript"], "answer": "Python"},
    {"question": "Quốc gia nào có dân số đông nhất?", "options": ["Ấn Độ", "Trung Quốc", "Mỹ", "Indonesia"], "answer": "Ấn Độ"},
    {"question": "Thành phố nào có nhiều tòa nhà chọc trời nhất?", "options": ["New York", "Dubai", "Hồng Kông", "Thượng Hải"], "answer": "Hồng Kông"},
    {"question": "Loài động vật nào nhanh nhất?", "options": ["Cheetah", "Đại bàng", "Cá mập", "Ngựa"], "answer": "Cheetah"},
    {"question": "Kim tự tháp nằm ở quốc gia nào?", "options": ["Peru", "Ai Cập", "Mexico", "Trung Quốc"], "answer": "Ai Cập"},
    {"question": "Ai là nhà vật lý nổi tiếng với thuyết tương đối?", "options": ["Newton", "Einstein", "Tesla", "Galileo"], "answer": "Einstein"},
    {"question": "Tháng nào có 28 hoặc 29 ngày?", "options": ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4"], "answer": "Tháng 2"},
    {"question": "Ngôn ngữ chính thức của Brazil?", "options": ["Tiếng Tây Ban Nha", "Tiếng Bồ Đào Nha", "Tiếng Anh", "Tiếng Ý"], "answer": "Tiếng Bồ Đào Nha"},
  ];

  int selectedAnswerIndex = -1;

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
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Column(
                  children: List.generate(
                    questions[index]['options'].length,
                    (optionIndex) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedAnswerIndex = optionIndex;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedAnswerIndex == optionIndex
                                      ? Colors.green
                                      : Colors.blue,
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                child: Text(
                                  questions[index]['options'][optionIndex],
                                  style: const TextStyle(fontSize: 18),
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
