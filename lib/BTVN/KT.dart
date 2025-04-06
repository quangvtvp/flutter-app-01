import 'package:flutter/material.dart';

class TodoList_app extends StatelessWidget {
  const TodoList_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [AppBar(), Placeholder()],
        ),
      ),
    );
  }
}
