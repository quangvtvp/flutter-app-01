import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: RowAndColumn(),
  ));
}

class RowAndColumn extends StatelessWidget {
  const RowAndColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Row and Column'),
      ),
      body: Column(
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
          const Divider(color: Colors.black, height: 1, thickness: 1),
          _buildRow7(),
          const Divider(color: Colors.black, height: 1, thickness: 1),
          _buildRow8(),
          const Divider(color: Colors.black, height: 1, thickness: 1),
        ],
      ),
    );
  }

  Widget _buildRow1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Colors.blue,
          width: 100,
          height: 75,
          child: const Center(
            child: Text(
              'Hello',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildRow2() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.red,
            height: 75,
            child: const Center(
              child: Text(
                'hello',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.blue,
            height: 75,
            child: const Center(
              child: Text(
                'word',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRow3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 15,
          child: Container(
            color: const Color.fromARGB(255, 98, 140, 98),
            width: 100,
            height: 75,
            child: const Center(
              child: Text(
                'hello',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.grey,
            width: 100,
            height: 75,
            child: const Center(
              child: Text(
                'word',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRow4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          color: const Color.fromARGB(255, 63, 170, 227),
          width: 40,
          height: 75,
          child: const Center(
            child: Text(
              'hello',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildRow5() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          color: Colors.red,
          width: 40,
          height: 75,
          child: const Center(
            child: Text(
              'hello',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          color: Colors.blue,
          width: 40,
          height: 75,
          child: const Center(
            child: Text(
              'word',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildRow6() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Colors.red,
          width: 50,
          height: 75,
          child: const Center(
            child: Text(
              'TUYEN',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Spacer(flex: 20),
        Container(
          color: Colors.blue,
          width: 50,
          height: 75,
          child: const Center(
            child: Text(
              'Tuyen',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildRow7() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 70,
        ),
      ],
    );
  }

  Row _buildRow8() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Colors.red,
          width: 40,
          height: 100,
          child: const Center(
            child: Text(
              'hello',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          color: Colors.blue,
          width: 40,
          height: 100,
          child: const Center(
            child: Text(
              'word',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
