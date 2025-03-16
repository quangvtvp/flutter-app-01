import 'package:flutter/material.dart';

class ContainerColor extends StatefulWidget {
  const ContainerColor({super.key});

  @override
  State<ContainerColor> createState() => _ContainerColorState();
}

class _ContainerColorState extends State<ContainerColor> {
  final List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
    Colors.cyan,
  ];
  int colorIndex = 8;

  void changeColor() {
    setState(() {
      colorIndex = (colorIndex + 1) % colors.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors[colorIndex],
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            changeColor();
          },
          child: Text('Change color $colorIndex'),
        ),
      ),
    );
  }
}
