import 'package:flutter/material.dart';

class MyQuestionPageView extends StatelessWidget {
  const MyQuestionPageView({super.key});

  @override
  Widget build(BuildContext context) {
    var pageController = PageController(viewportFraction: 0.8);
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 450,
            child: PageView(
              controller: pageController,
              // refactor to use PageView.builder
              // define list of data via class object
              children: [
                MyChoice(
                  question: 'What is the capital of France?',
                  options: ["London", "Berlin", "Paris", "Rome"],
                ),
                MyChoice(
                  question: 'What is the capital of Vietnam?',
                  options: ["London", "Berlin", "Hanoi", "Rome"],
                ),
                MyChoice(
                  question: 'What is the capital of Lao?',
                  options: ["Vienchang", "Berlin", "Paris", "Rome"],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
          // add tab view indicator
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('BACK'),
              ),
              ElevatedButton(
                onPressed: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('NEXT'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyChoice extends StatefulWidget {
  final String question;
  final List<String> options;
  const MyChoice({super.key, required this.question, required this.options});

  @override
  State<MyChoice> createState() => _MyChoiceState();
}

class _MyChoiceState extends State<MyChoice> {
  String? selectedOption; // Lưu đáp án được chọn

  final List<String> options = ["London", "Berlin", "Paris", "Rome"];
  final String correctAnswer = "Paris"; // Đáp án đúng
  bool isCheck = false;
  void checkAnswer() {
    setState(() {
      isCheck = true;
    });
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
          height: 400,
          child: Card(
            color: Colors.white,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.question,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Danh sách câu trả lời
                  Column(
                    children: widget.options.map((option) {
                      var radioListTile = RadioListTile<String>(
                        title: Text(
                          option,
                          style: TextStyle(
                            fontSize: 20,
                            color: isCheck
                                ? (option == correctAnswer
                                    ? Colors.green // Đúng -> Xanh
                                    : (option == selectedOption
                                        ? Colors.red
                                        : Colors.black)) // Sai -> Đỏ
                                : Colors.black,
                          ),
                        ), // Mặc định đen),
                        value: option,

                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value;
                          });
                        },

                        activeColor: Colors.deepPurple,
                      );
                      return radioListTile;
                    }).toList(),
                  ),

                  // Nút kiểm tra đáp án
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
