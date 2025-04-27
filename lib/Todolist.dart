import 'package:flutter/material.dart';

class MyTodo extends StatelessWidget {
  const MyTodo({super.key});

  @override
  Widget build(BuildContext context) {
    {
      return Scaffold(
          appBar: AppBar(
        title: const Text('Todo list'),
        backgroundColor: const Color.fromARGB(255, 129, 35, 112),
        centerTitle: true,
      ));
    }
  }
}
class build extends StatefulWidget {
  const build({super.key});

  @override
  State<build> createState() => _buildState();
}

class _buildState extends State<build> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}