import 'package:flutter/material.dart';

class BT_HS extends StatelessWidget {
  const BT_HS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Align(
      alignment: Alignment.topCenter,
      child: Container(
          color: Colors.blue[100],
          margin: const EdgeInsets.all(20),
          width: 400,
          height: 400,
          child: Column(
            children: [
              Icon(
                Icons.person,
                size: 100,
              ),
              Text('name', style: TextStyle(fontSize: 65, color: Colors.red)),
              Text('Date', style: TextStyle(fontSize: 65, color: Colors.red)),
              IconButton(onPressed: () {}, icon: Icon(Icons.shuffle, size: 50)),
            ],
          )),
    )));
  }
}
