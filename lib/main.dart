import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 236, 219),
      body: Center(
        child: 
        StockCard(
          symbol: "APPL",
          company: "Apple Inc",
          price: 142.90,
          change: 0.63,
        ),
      ),
    ),
  ));
}

class StockCard extends StatelessWidget {
  final String symbol;
  final String company;
  final double price;
  final double change;

  const StockCard({
    super.key,
    required this.symbol,
    required this.company,
    required this.price,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(40), 
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [RichText(
  text: TextSpan(
    children: [
      TextSpan(text: "A", style: TextStyle(color: Colors.red, fontSize: 24)),
      TextSpan(text: "P", style: TextStyle(color: Colors.blue, fontSize: 24)),
      TextSpan(text: "P", style: TextStyle(color: Colors.green, fontSize: 24)),
      TextSpan(text: "L", style: TextStyle(color: Colors.orange, fontSize: 24)),
    ],
  ),
 ),
          Text(company,
              style: TextStyle(fontSize: 13, color: const Color.fromARGB(255, 255, 209, 174))),

          const SizedBox(height: 25),
          Text("\$$price",
              style:
                  const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),

          const SizedBox(height: 10),
     Text(
            "${change.toStringAsFixed(2)}%",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: change > 0 ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
