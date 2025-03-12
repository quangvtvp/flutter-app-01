import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50),
              ),
              alignment: Alignment.center,
              width: 500,
              height: 500,
              child: MyWeatherCard())),
    ));
  }
}

class MyWeatherCard extends StatefulWidget {
  const MyWeatherCard({super.key});

  @override
  State<MyWeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<MyWeatherCard> {
  String Locate = 'Los AngeLes';
  double TemperatureC = 43;
  // 1 cái biến image nữa
  // và description nữa

  // void doSomething() {
  //   setState(() {
  //     Locate = Locate;
  //     TemperatureC = TemperatureC;
  //   });
  // }  chưa cần đến

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('$Locate', style: TextStyle(fontSize: 50, color: Colors.black)),
          Icon(
            Icons.access_alarm,
            size: 200,
          ),
          Text('$TemperatureC°C',
              style: TextStyle(fontSize: 50, color: Colors.black)),
          Text('data', style: TextStyle(fontSize: 50, color: Colors.black45))
        ]);
  }
}
