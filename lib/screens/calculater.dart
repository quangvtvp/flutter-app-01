import 'package:flutter/material.dart';

void main() {
  runApp(const MyCalculater());
}

class MyCalculater extends StatelessWidget {
  const MyCalculater({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const CalculaterScreen(),
    );
  }
}

class CalculaterScreen extends StatefulWidget {
  const CalculaterScreen({super.key});

  @override
  State<CalculaterScreen> createState() => _calculaterPageState();
}

// ignore: camel_case_types
class _calculaterPageState extends State<CalculaterScreen> {
  String _dispLay = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            //khu 1 hien thi so
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomRight,
                child: SelectableText(
                  _dispLay,
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // khu 2 hien thi cac phim tinh toan
            Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildButton(
                            'AC',
                            bgColor: Colors.grey,
                          ),
                          _buildButton('+/-'),
                          _buildButton('%'),
                          _buildButton(
                            '÷',
                            bgColor: Colors.orange,
                          ),
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
                          _buildButton(
                            'x',
                            bgColor: Colors.orange,
                          ),
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
                          _buildButton(
                            '-',
                            bgColor: Colors.orange,
                          ),
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
                          _buildButton(
                            '+',
                            bgColor: Colors.orange,
                          ),
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
                          _buildButton(
                            '=',
                            bgColor: Colors.orange,
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, {Color? bgColor = const Color(0xFF333333)}) {
    return Expanded(
      child: CalButton(
        text: text,
        bgColor: bgColor ?? const Color(0xFF333333),
        onPressed: () {
          setState(() {
            if (text == 'AC') {
              _dispLay = '0';
            } else {
              _dispLay = text;
            }
          });
          setState(() {
            if (text == '=') {
              double result;
              try {
                result = double.parse(_dispLay);
              } catch (e) {
                return;
              }
              _dispLay = result.toStringAsFixed(2);
            } else if (text == '+/-' || text == '%') {
              double result = double.parse(_dispLay);
              if (text == '+/-') {
                result *= -1;
              } else if (text == '%') {
                result /= 100;
              }
              _dispLay = result.toStringAsFixed(2);
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
  final VoidCallback? onPressed;

  const CalButton({
    super.key,
    required this.text,
    this.bgColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: bgColor ?? const Color(0xFF333333),
            shape: const CircleBorder()),
        child: Text(text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
