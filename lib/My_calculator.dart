import 'package:flutter/material.dart';

class MyCalculator extends StatelessWidget {
  const MyCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              child: SelectableText(
                '000',
                style: TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  Row(
                    children: [
                      CaButton(text: '1',bgColor: Colors.amber,),
                      CaButton(
                        text: '1',
                        bgColor: Colors.amber,
                      ),
                      CaButton(
                        text: '1',
                        bgColor: Colors.amber,
                      ),
                      CaButton(
                        text: '1',
                        bgColor: Colors.amber,
                      ),
                      CaButton(
                        text: '1',
                        bgColor: Colors.amber,
                      ),
                    ],
                  ),
                ],
              ))
        ],
      )),
    );
  }
}

class CaButton extends StatelessWidget {
  final String text;
  final Color? bgColor;

  CaButton({
    required this.text,
    this.bgColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print('Click ');
      },
      child: Text('1'),
      style: ElevatedButton.styleFrom(backgroundColor: bgColor ?? Color(0xFF333333),
      shape: CircleBorder()),
    );
  }
}
