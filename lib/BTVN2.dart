import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StockScreen(),
  ));
}

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> stocks = [
      {
        "symbol": "AAPL",
        "company": "Apple Inc.",
        "price": 142.90,
        "change": 0.63
      },
      {
        "symbol": "GOOGL",
        "company": "Alphabet Inc.",
        "price": 2789.61,
        "change": -1.25
      },
      {
        "symbol": "TSLA",
        "company": "Tesla Inc.",
        "price": 699.10,
        "change": 2.47
      },
      {
        "symbol": "AMZN",
        "company": "Amazon Inc.",
        "price": 3450.56,
        "change": -0.75
      },
      {
        "symbol": "MSFT",
        "company": "Microsoft Corp.",
        "price": 299.25,
        "change": 1.12
      },
      {
        "symbol": "NFLX",
        "company": "Netflix Inc.",
        "price": 590.65,
        "change": -0.23
      },
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 236, 219),
      appBar: AppBar(
        title: const Text("Stock Market"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.2,
          ),
          itemCount: stocks.length,
          itemBuilder: (context, index) {
            return StockCard(
              symbol: stocks[index]["symbol"],
              company: stocks[index]["company"],
              price: stocks[index]["price"],
              change: stocks[index]["change"],
            );
          },
        ),
      ),
    );
  }
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: symbol.split('').asMap().entries.map((entry) {
                final colors = [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.orange
                ];
                return TextSpan(
                  text: entry.value,
                  style: TextStyle(
                    color: colors[entry.key % colors.length],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            company,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          const SizedBox(height: 15),
          Text(
            "\$${price.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
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
