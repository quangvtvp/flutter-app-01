import 'package:flutter/material.dart';

class NextColor extends StatefulWidget {
  const NextColor({super.key});

  @override
  State<NextColor> createState() => _NextColorState();
}

class _NextColorState extends State<NextColor> {
  final List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];
  int _currentColorIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _colors[_currentColorIndex],
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _currentColorIndex = (_currentColorIndex + 1) % _colors.length;
            });
          },
          child: const Text('Change Color'),
        ),
      ),
    );
  }
}
