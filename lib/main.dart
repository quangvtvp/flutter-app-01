import 'package:flutter/material.dart';
import 'package:flutter_application/BTVN/KT.dart';

void main() {
  runApp(MyJsonPage());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text("hello world"),
      ),
    );
  }
}
