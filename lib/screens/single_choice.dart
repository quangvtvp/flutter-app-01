import 'package:flutter/material.dart';

class MyChoice extends StatefulWidget {
  const MyChoice({super.key});

  @override
  State<MyChoice> createState() => _MyChoiceState();
}

class _MyChoiceState extends State<MyChoice> {
  String? selectedOption; // Lưu đáp án được chọn

  final List<String> options = ["London", "Berlin", "Paris", "Rome"];
  final String correctAnswer = "Paris"; // Đáp án đúng

  void checkAnswer() {
    if (selectedOption == correctAnswer) {
      print(" Correct Answer!");
    } else {
      print(" Wrong Answer!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single Choice'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 450,
          child: Card(
            color: Colors.white,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "What is the capital of France?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Danh sách câu trả lời
                  Column(
                    children: options.map((option) {
                      return RadioListTile<String>(
                        title:
                            Text(option, style: const TextStyle(fontSize: 20)),
                        value: option,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value;
                          });
                        },
                        activeColor: Colors.deepPurple,
                      );
                    }).toList(),
                  ),

                  const Spacer(),

                  // Nút kiểm tra đáp án
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onPressed: checkAnswer,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 32,
                        ),
                        child: Text("Check Answer",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
