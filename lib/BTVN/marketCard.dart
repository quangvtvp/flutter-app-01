import 'package:flutter/material.dart';

class MarketCard extends StatelessWidget {
  const MarketCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Container(
              alignment: Alignment(-0.5, 1.0), //căn lề thủ công, giống word
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              width: 500,
              height: 500,
              child: MyMarketCard())),
    ));
  }
}

class MyMarketCard extends StatefulWidget {
  const MyMarketCard({super.key});

  @override
  State<MyMarketCard> createState() => _MarketCardState();
}

class _MarketCardState extends State<MyMarketCard> {
  String name = 'AAPL';
  String CompanyName = 'Apple Inc';
  double price = 142.90;
  double volatility = 0.63;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Spacer(flex: 1),
      Text('$name',
          style: TextStyle(
              fontSize: 50, color: Colors.black, fontWeight: FontWeight.bold)),
      Text('$CompanyName', style: TextStyle(fontSize: 45, color: Colors.grey)),
      Spacer(flex: 2),
      Text("\$" + '$price',
          style: TextStyle(
              fontSize: 75, color: Colors.black, fontWeight: FontWeight.bold)),
      volatilityWidget(volatility),
      Spacer(flex: 1), //ko biết căn lề nên nhét space
    ]);
  }
}

Text volatilityWidget(double volatility) {
  if (volatility < 0)
    return Text('$volatility%',
        style: TextStyle(
            fontSize: 40, color: Colors.red, fontWeight: FontWeight.w100));
  return Text('+$volatility%',
      style: TextStyle(
          fontSize: 40, color: Colors.green, fontWeight: FontWeight.w100));
}
