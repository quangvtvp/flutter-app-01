import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WeatherForecastScreen(),
  ));
}

class WeatherForecastScreen extends StatefulWidget {
  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  int selectedDayIndex = 0; // Chỉ số ngày được chọn

  final List<List<Map<String, dynamic>>> weeklyHourlyWeather = [
    // Dữ liệu theo giờ của từng ngày trong tuần
    [
      {"time": "07:00", "temp": "14°C", "icon": Icons.cloud},
      {"time": "08:00", "temp": "14°C", "icon": Icons.cloud},
      {"time": "09:00", "temp": "15°C", "icon": Icons.cloud},
      {"time": "10:00", "temp": "15°C", "icon": Icons.cloud},
      {"time": "11:00", "temp": "16°C", "icon": Icons.cloud},
    ],
    [
      {"time": "07:00", "temp": "10°C", "icon": Icons.ac_unit},
      {"time": "08:00", "temp": "12°C", "icon": Icons.ac_unit},
      {"time": "09:00", "temp": "14°C", "icon": Icons.cloud},
      {"time": "10:00", "temp": "15°C", "icon": Icons.cloud},
      {"time": "11:00", "temp": "16°C", "icon": Icons.cloud},
    ],
    [
      {"time": "07:00", "temp": "17°C", "icon": Icons.cloud},
      {"time": "08:00", "temp": "18°C", "icon": Icons.cloud},
      {"time": "09:00", "temp": "19°C", "icon": Icons.cloud},
      {"time": "10:00", "temp": "20°C", "icon": Icons.cloud},
      {"time": "11:00", "temp": "21°C", "icon": Icons.cloud},
    ],
    [
      {"time": "07:00", "temp": "22°C", "icon": Icons.wb_sunny},
      {"time": "08:00", "temp": "23°C", "icon": Icons.wb_sunny},
      {"time": "09:00", "temp": "24°C", "icon": Icons.wb_sunny},
      {"time": "10:00", "temp": "25°C", "icon": Icons.wb_sunny},
      {"time": "11:00", "temp": "26°C", "icon": Icons.wb_sunny},
    ],
    [
      {"time": "07:00", "temp": "21°C", "icon": Icons.cloud},
      {"time": "08:00", "temp": "22°C", "icon": Icons.cloud},
      {"time": "09:00", "temp": "23°C", "icon": Icons.cloud},
      {"time": "10:00", "temp": "24°C", "icon": Icons.cloud},
      {"time": "11:00", "temp": "25°C", "icon": Icons.cloud},
    ],
    [
      {"time": "07:00", "temp": "20°C", "icon": Icons.wb_sunny},
      {"time": "08:00", "temp": "21°C", "icon": Icons.wb_sunny},
      {"time": "09:00", "temp": "22°C", "icon": Icons.wb_sunny},
      {"time": "10:00", "temp": "23°C", "icon": Icons.wb_sunny},
      {"time": "11:00", "temp": "24°C", "icon": Icons.wb_sunny},
    ],
    [
      {"time": "07:00", "temp": "19°C", "icon": Icons.cloud},
      {"time": "08:00", "temp": "20°C", "icon": Icons.cloud},
      {"time": "09:00", "temp": "21°C", "icon": Icons.cloud},
      {"time": "10:00", "temp": "22°C", "icon": Icons.cloud},
      {"time": "11:00", "temp": "23°C", "icon": Icons.cloud},
    ],
  ];

  final List<Map<String, dynamic>> weeklyWeather = [
    {"day": "Monday", "temp": "18°/16°", "icon": Icons.cloud},
    {"day": "Tuesday", "temp": "16°/15°", "icon": Icons.ac_unit},
    {"day": "Wednesday", "temp": "19°/16°", "icon": Icons.cloud},
    {"day": "Thursday", "temp": "22°/20°", "icon": Icons.wb_sunny},
    {"day": "Friday", "temp": "23°/21°", "icon": Icons.cloud},
    {"day": "Saturday", "temp": "24°/22°", "icon": Icons.wb_sunny},
    {"day": "Sunday", "temp": "21°/19°", "icon": Icons.cloud},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              children: List.generate(weeklyWeather.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDayIndex = index; // Cập nhật ngày được chọn
                    });
                  },
                  child: WeeklyWeatherCard(
                    day: weeklyWeather[index]["day"],
                    temp: weeklyWeather[index]["temp"],
                    icon: weeklyWeather[index]["icon"],
                  ),
                );
              }),
            ),
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

  const WeeklyWeatherCard(
      {required this.day, required this.temp, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.grey[850],
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
      ),
    );
  }
}
