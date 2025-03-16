import 'package:flutter/material.dart';

class MyWeather extends StatelessWidget {
  const MyWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 320,
      child: Card(
          color: Colors.white,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'New York, NK',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                // cirle container
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow[600],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  '30°',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Mostly Sunny',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black38,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
