import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }

  Row _buildRow3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          color: Colors.red,
          width: 100,
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: 200,
            height: 200,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(children: [
                Text("data"),
                Text("data"),
                Text("data"),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildRow2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Colors.red,
          width: 100,
          height: 100,
        ),
        Container(
          color: Colors.green,
          width: 100,
          height: 100,
        ),
        const Expanded(
          child: SizedBox(),
        ),
        Container(
          color: Colors.deepPurple,
          width: 100,
          height: 100,
        ),
      ],
    );
  }

  Row _buildRow1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.red,
            width: 100,
            height: 100,
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.green,
            width: 100,
            height: 100,
          ),
        ),
      ],
    );
  }
}
