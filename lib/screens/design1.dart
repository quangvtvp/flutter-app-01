import 'package:flutter/material.dart';

class ContainerColor extends StatefulWidget {
  const ContainerColor({super.key});

  @override
  State<ContainerColor> createState() => _ContainerColorState();
}

class _ContainerColorState extends State<ContainerColor> {
    final List<Color> colors = [
        Colors.cyan,
        Colors.red,
        Colors.purpleAccent,
    ];
    int colorIndex = 0;
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
                child: Text('doi mau $colorIndex'),
            ),
        )
    );
  }
}
