import 'package:flutter/material.dart';

class RowAndColumn extends StatelessWidget {
  const RowAndColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('nguyen duc hieu'),
      ),
      body: Column(
        children: [
          _buildRow1(),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
          _buildRow2(),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
          _buildRow3(),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
          _buildRow4(),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
          _buildRow5(),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
          _buildRow6(),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
          _buildRow7(),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
        ],
      ),
    );
  }

Row _buildRow7() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: 100,
        ),
        Container(
          color: const Color.fromARGB(255, 246, 7, 7),
          width: 25,
          height: 50,
          child: const Column(children: [
            Text("H"),
          ])
        ),
        Container(
          color: const Color.fromARGB(255, 0, 8, 241),
          width: 25,
          height: 50,
          child: const Column(children: [
            Text("Q"),
          ])
        ),
      ],
    );
  }

Row  _buildRow6() {
     return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: const Color.fromARGB(255, 225, 15, 4),
          width: 25,
          height: 50,
          child: const Column(children: [
            Text("H"),
          ])
        ),
        Container(
          color: const Color.fromARGB(255, 4, 37, 225),
          width: 25,
          height: 50,
          child: const Column(children: [
            Text("Q"),
          ])
        ),
      ],
     );
}

Row  _buildRow5() {
     return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          color: const Color.fromARGB(255, 225, 15, 4),
          width: 25,
          height: 50,
          child: const Column(children: [
            Text("H"),
          ])
        ),
        Container(
          color: const Color.fromARGB(255, 4, 37, 225),
          width: 25,
          height: 50,
          child: const Column(children: [
            Text("Q"),
          ])
        ),
      ],
     );
}

Row  _buildRow4() {
     return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        Container(
          color: const Color.fromARGB(255, 77, 4, 225),
          width: 25,
          height: 50,
          child: const Column(children: [
            Text("Q"),
          ])
        ),
      ],
     );
}

Row _buildRow3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 9,
        child: Container(
          color: const Color.fromARGB(128, 8, 146, 38),
          width: 50,
          height: 50,
          child: const Column(children: [
            Text("H"),
          ])
        ),
        ),
        Expanded(
          flex: 1,
        child: Container(
          color: const Color.fromARGB(255, 130, 130, 130),
          width: 50,
          height: 50,
          child: const Column(children: [
            Text("Q"),
          ])
        ),
        ),
      ],
    );
  }

Row _buildRow2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
        child: Container(
          color: Colors.red,
          width: 50,
          height: 50,
          child: const Column(children: [
            Text("H"),
          ])
        ),
        ),
        Expanded(
          flex: 1,
        child: Container(
          color: const Color.fromARGB(255, 0, 14, 165),
          width: 50,
          height: 50,
          child: const Column(children: [
            Text("Q"),
          ])
        ),
        ),
      ],
    );
  }

Row _buildRow1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: const Color.fromARGB(119, 99, 70, 1),
          width: 25,
          height: 50,
          child: const Column(children: [
            Text("H"),
          ])
        ),
        Container(
          color: const Color.fromARGB(255, 0, 8, 241),
          width: 25,
          height: 50,
          child: const Column(children: [
            Text("Q"),
          ])
        ),
      ],
    );
  }
}
