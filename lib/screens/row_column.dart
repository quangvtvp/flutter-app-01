import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: RowAndColumn(),
    );
  }
}

class RowAndColumn extends StatelessWidget {
  const RowAndColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Row and Column'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildRow1(),
            const Divider(color: Colors.black, height: 1, thickness: 1),
            _buildRow2(),
            const Divider(color: Colors.black, height: 1, thickness: 1),
            _buildRow3(),
            const Divider(color: Colors.black, height: 1, thickness: 1),
            _buildRow4(),
            const Divider(color: Colors.black, height: 1, thickness: 1),
            _buildRow5(),
            const Divider(color: Colors.black, height: 1, thickness: 1),
            _buildRow6(),
          ],
        ),
      ),
    );
  }

  Widget _buildRow1() {
    return Row(
      children: [
        Expanded(
            child: Container(
                color: Colors.brown,
                height: 50,
                child: const Center(child: Text('HelloWorld')))),
      ],
    );
  }

  Widget _buildRow2() {
    return Row(
      children: [
        Expanded(
            child: Container(
                color: Colors.red,
                height: 50,
                child: const Center(child: Text('Hello')))),
        Expanded(
            child: Container(
                color: Colors.blue,
                height: 50,
                child: const Center(child: Text('World')))),
      ],
    );
  }

  Widget _buildRow3() {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Container(
                color: Colors.green,
                height: 50,
                child: const Center(child: Text('Hello')))),
        Expanded(
            child: Container(
                color: Colors.grey,
                height: 50,
                child: const Center(child: Text('World')))),
      ],
    );
  }

  Widget _buildRow4() {
    return Row(
      children: [
        Expanded(child: Container(height: 50)),
        Expanded(
            child: Container(
                color: Colors.red,
                height: 50,
                child: const Center(child: Text('Hello')))),
        Expanded(child: Container(height: 50)),
        Expanded(
            child: Container(
                color: Colors.blue,
                height: 50,
                child: const Center(child: Text('World')))),
      ],
    );
  }

  Widget _buildRow5() {
    return Row(
      children: [
        Container(
            width: 50,
            height: 50,
            color: Colors.red,
            child: const Center(child: Text('Hello'))),
        Expanded(child: Container(height: 50)),
        Container(
            width: 50,
            height: 50,
            color: Colors.blue,
            child: const Center(child: Text('World'))),
      ],
    );
  }

  Widget _buildRow6() {
    return Row(
      children: [
        Container(
            width: 50,
            height: 50,
            color: Colors.red,
            child: const Center(child: Text('HelloWorld'))),
        Expanded(child: Container(height: 50)),
      ],
    );
  }
}
