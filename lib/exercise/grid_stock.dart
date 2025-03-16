import 'package:flutter/material.dart';
import 'package:flutter_application/exercise/stock.dart';

class GridStock extends StatelessWidget {
  const GridStock({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.count(
          childAspectRatio: 1,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          padding: const EdgeInsets.all(8),
          crossAxisCount: 2,
          children: List<Widget>.generate(20, (index) {
            return const MyStock();
          }),
        ),
      ),
    );
  }
}
