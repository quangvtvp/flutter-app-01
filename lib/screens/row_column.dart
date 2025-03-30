import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

<<<<<<< HEAD
class MyApp extends StatelessWidget {
  const MyApp({super.key});

=======
class WeaatherModel {
  final String day;
  final String temp;
  final IconData icon;

  WeaatherModel({required this.day, required this.temp, required this.icon});
}

class WeatherForecastScreen extends StatefulWidget {
>>>>>>> 068f1fbaf8e92313a95cd12bd7f689e86311c3da
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

<<<<<<< HEAD
  Map<int, int> selectedAnswers = {}; // Lưu đáp án đã chọn
=======
  // final List<Map<String, dynamic>> weeklyWeather = [
  //   {"day": "Monday", "temp": "18°/16°", "icon": Icons.cloud},
  //   {"day": "Tuesday", "temp": "16°/15°", "icon": Icons.ac_unit},
  //   {"day": "Wednesday", "temp": "19°/16°", "icon": Icons.cloud},
  //   {"day": "Thursday", "temp": "22°/20°", "icon": Icons.wb_sunny},
  //   {"day": "Friday", "temp": "23°/21°", "icon": Icons.cloud},
  //   {"day": "Saturday", "temp": "24°/22°", "icon": Icons.wb_sunny},
  //   {"day": "Sunday", "temp": "21°/19°", "icon": Icons.cloud},
  // ];

  final List<WeaatherModel> weekWeatherList = [
    WeaatherModel(day: "Monday", temp: "18°/16°", icon: Icons.cloud),
    WeaatherModel(day: "Tuesday", temp: "16°/15°", icon: Icons.ac_unit),
    WeaatherModel(day: "Wednesday", temp: "19°/16°", icon: Icons.cloud),
  ];
>>>>>>> 068f1fbaf8e92313a95cd12bd7f689e86311c3da

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
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
=======
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("Weather Forecast"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          // Hàng trên: Dự báo theo giờ của ngày được chọn
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: weeklyHourlyWeather[selectedDayIndex].map((data) {
                return HourlyWeatherCard(
                  time: data["time"],
                  temp: data["temp"],
                  icon: data["icon"],
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 10),
          // Hàng dưới: Dự báo theo ngày
          Container(
            height: 80, // Chiều cao nhỏ hơn 1/4
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(weekWeatherList.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDayIndex = index; // Cập nhật ngày được chọn
                    });
                  },
                  child: WeeklyWeatherCard(
                    day: weekWeatherList[index].day,
                    temp: weekWeatherList[index].temp,
                    icon: weekWeatherList[index].icon,
                    isSelected: index == selectedDayIndex,
>>>>>>> 068f1fbaf8e92313a95cd12bd7f689e86311c3da
                  ),
                ),
              ],
            ),
<<<<<<< HEAD
          );
        },
=======
          ),
        ],
      ),
    );
  }
}

// Card dự báo thời tiết theo giờ
class HourlyWeatherCard extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;

  const HourlyWeatherCard(
      {required this.time, required this.temp, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.grey[850],
      child: Container(
        width: 70,
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(time, style: TextStyle(fontSize: 12, color: Colors.white)),
            Icon(icon, size: 20, color: Colors.white),
            Text(temp, style: TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

// Card dự báo thời tiết theo ngày
class WeeklyWeatherCard extends StatelessWidget {
  final String day;
  final String temp;
  final IconData icon;
  final bool isSelected;

  const WeeklyWeatherCard(
      {super.key,
      required this.day,
      required this.temp,
      required this.icon,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: isSelected ? Colors.blue[200] : Colors.grey[850],
      child: Container(
        width: 80,
        height: 70,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: Colors.white),
            const SizedBox(height: 4),
            Text(day.substring(0, 3),
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 2),
            Text(temp,
                style: const TextStyle(fontSize: 10, color: Colors.white70)),
          ],
        ),
>>>>>>> 068f1fbaf8e92313a95cd12bd7f689e86311c3da
      ),
    );
  }
}
