import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WeatherScreen(),
  ));
}

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("Weather Forecast"),
        backgroundColor: Colors.black54,
      ),
      body: Column(
        children: [
          SizedBox(height: 100),
          HourlyForecast(),
          SizedBox(height: 1),
          Expanded(child: DailyForecast()),
        ],
      ),
    );
  }
}

class HourlyForecast extends StatelessWidget {
  final List<Map<String, dynamic>> hourlyData = [
    {"time": "07:00", "temp": 14, "icon": Icons.cloud},
    {"time": "08:00", "temp": 14, "icon": Icons.cloud},
    {"time": "09:00", "temp": 15, "icon": Icons.cloud},
    {"time": "10:00", "temp": 15, "icon": Icons.cloud},
    {"time": "11:00", "temp": 16, "icon": Icons.cloud},
    {"time": "12:00", "temp": 16, "icon": Icons.cloud},
    {"time": "13:00", "temp": 17, "icon": Icons.cloud},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.975,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hourlyData.length,
            itemBuilder: (context, index) {
              return HourlyWeatherCard(
                time: hourlyData[index]["time"],
                temp: hourlyData[index]["temp"],
                icon: hourlyData[index]["icon"],
              );
            },
          ),
        ),
      ),
    );
  }
}

class HourlyWeatherCard extends StatelessWidget {
  final String time;
  final int temp;
  final IconData icon;

  const HourlyWeatherCard({
    super.key,
    required this.temp,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 7.4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: TextStyle(color: Colors.white, fontSize: 14)),
          Spacer(),
          Icon(icon, color: Colors.white, size: 40),
          SizedBox(height: 8),
          Text("$temp°C", style: TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}

class DailyForecast extends StatelessWidget {
  final List<Map<String, dynamic>> dailyData = [
    {
      "day": "Monday",
      "maxTemp": 18,
      "minTemp": 16,
    },
    {
      "day": "Tuesday",
      "maxTemp": 16,
      "minTemp": 15,
    },
    {
      "day": "Wednesday",
      "maxTemp": 19,
      "minTemp": 16,
    },
    {
      "day": "Thursday",
      "maxTemp": 22,
      "minTemp": 20,
    },
    {
      "day": "Friday",
      "maxTemp": 23,
      "minTemp": 21,
    },
    {
      "day": "Saturday",
      "maxTemp": 25,
      "minTemp": 20,
    },
    {
      "day": "Sunday",
      "maxTemp": 22,
      "minTemp": 16,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal, //vuốt ngang
          itemCount: dailyData.length,
          itemBuilder: (context, index) {
            return DailyWeatherCard(
              day: dailyData[index]["day"],
              maxTemp: dailyData[index]["maxTemp"],
              minTemp: dailyData[index]["minTemp"],
            );
          },
        ),
      ),
    );
  }
}

class DailyWeatherCard extends StatelessWidget {
  final String day;
  final int maxTemp;
  final int minTemp;

  const DailyWeatherCard({
    super.key,
    required this.day,
    required this.maxTemp,
    required this.minTemp,
  });
  IconData getWeatherIcon(int temp) {
    if (minTemp >= 19) {
      return Icons.wb_sunny;
    } else if (minTemp >= 16) {
      return Icons.cloud;
    } else{
        return Icons.ac_unit;
      }
  }
  Color getWeatherColor(int temp) {
    if (temp >= 19) {
      return Colors.orangeAccent;
    } else if (temp >= 16) {
      return const Color.fromARGB(255, 135, 150, 157);
    } else {
      return Colors.lightBlueAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue, width: sqrt1_2) // viền
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(day,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
                  Icon(
            getWeatherIcon(minTemp),
            color: getWeatherColor(minTemp), // Áp dụng màu theo nhiệt độ
            size: 30,
          ),

          Text("$maxTemp°/$minTemp°",
              style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
