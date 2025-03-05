import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            color: Colors.blue[100],
            margin: const EdgeInsets.all(20),
            width: 200,
            height: 200,
            child: const Column(
              children: [
                Icon(Icons.person_2, size: 100, color: Colors.blue),
                Text(
                  'Nguyen Van A',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  '20/01/2007',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
