import 'package:flutter/material.dart';

class MyCalculatorApp extends StatelessWidget {
  const MyCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '99';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            children: [
              // khu vuc 1: hien thi so
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: SelectableText(
                    _display,
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // khu vuc so 2: keyboards
              Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildButton('AC', bgColor: Colors.grey),
                            _buildButton('+/-'),
                            _buildButton('%'),
                            _buildButton('÷', bgColor: Colors.orange),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildButton('7'),
                            _buildButton('8'),
                            _buildButton('9'),
                            _buildButton('x', bgColor: Colors.orange),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildButton('4'),
                            _buildButton('5'),
                            _buildButton('6'),
                            _buildButton('-', bgColor: Colors.orange),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildButton('1'),
                            _buildButton('2'),
                            _buildButton('3'),
                            _buildButton('+', bgColor: Colors.orange),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildButton('0'),
                            _buildButton(','),
                            _buildButton('.'),
                            _buildButton('=', bgColor: Colors.orange),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildButton(String text, {Color? bgColor = const Color(0xFF333333)}) {
    return Expanded(
      child: CalButton(
        text: text,
        bgColor: bgColor ?? Color(0xFF333333),
        onPressed: () {
          setState(() {
            if(text == 'AC') {
              _display = '0';
            } else {
              _display = text;  
            }
            
          });
        },
      ),
    );
  }
}

class CalButton extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final VoidCallback onPressed;
  const CalButton({
    super.key,
    required this.text,
    this.bgColor, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? Color(0xFF333333),
          foregroundColor: Colors.white,
          shape: CircleBorder(),
        ),
      ),
    );
  }
}
