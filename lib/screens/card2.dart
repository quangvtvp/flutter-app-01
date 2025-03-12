
// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class Card2 extends StatelessWidget {
  const Card2({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: const Text('Card'),
      ),
      
      body: 
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("AAPL",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 5),
                Text("Apple Inc", style: TextStyle(color: Colors.grey)),
                SizedBox(height: 15),
                Text("\$142.90",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                SizedBox(height: 5),
                Text("+0.63%",
                    style: TextStyle(color: Colors.green, fontSize: 16)),
              ],
            ),
          ),
      )
   );
  }
}
