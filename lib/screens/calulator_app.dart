import 'package:flutter/material.dart';

class MyCaculator extends StatelessWidget {
  const MyCaculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Calculator',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const MyCalculatorScreen(),
    );
  }
}

class MyCalculatorScreen extends StatefulWidget {
  const MyCalculatorScreen({super.key});

  @override
  State<MyCalculatorScreen> createState() => _MyCalculatorScreenState();
}

class _MyCalculatorScreenState extends State<MyCalculatorScreen> {
  final String buttonDigits = '0123456789';
  final String operators = '+-*:';
  String _displayText = '0';
  String _currentInput = '';
  int _result = 0;
  String _operator = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 400,
            child: Column(children: [
              Expanded(
                flex: 2,
                child: _resultWidget(),
              ),
              Expanded(
                flex: 5,
                child: _keyBoards(),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _keyBoards() {
    return Container(
      color: Colors.black,
      child: Column(children: [
        Expanded(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildCalButton('AC'),
            _buildCalButton('2'),
            _buildCalButton('3'),
            _buildCalButton('4'),
          ]),
        ),
        Expanded(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildCalButton('5'),
            _buildCalButton('6'),
            _buildCalButton('7'),
            _buildCalButton('8'),
          ]),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCalButton('9', bgColor: Colors.red),
              _buildCalButton('0'),
              _buildCalButton('+'),
              _buildCalButton('-'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCalButton('9'),
              _buildCalButton('0'),
              _buildCalButton('+'),
              _buildCalButton('-'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCalButton('9'),
              _buildCalButton('0'),
              _buildCalButton('+'),
              _buildCalButton('='),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildCalButton(String text, {Color? bgColor}) => Expanded(
          child: CalButton(
        text: text,
        onPressed: () => _buttonClick(text),
        bgColor: bgColor ?? Color(0xFF333333),
      ));

  Container _resultWidget() {
    return Container(
      color: Colors.black,
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      child: SelectableText(
        _displayText,
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
        maxLines: 1,
      ),
    );
  }

  _buttonClick(String input) {
    setState(() {
      // kiem tra xem co phai la nhap so khong
      if (buttonDigits.contains(input)) {
        _currentInput += input;
        _displayText = _currentInput;
      } else if (operators.contains(input)) {
        // nhap phep tinh
        _operator = input;

        _calculate();
      } else if (input == '=') {
        _calculate();
      } else if (input == 'AC') {
        _clear();
      }
    });
  }

  void _clear() {
    _currentInput = '';
    _operator = '';
    _result = 0;
    _displayText = '0';
  }

  void _calculate() {
    setState(() {
      if (_operator.isEmpty || _currentInput.isEmpty) {
        if (_operator.isEmpty && _currentInput.isNotEmpty) {
          _result = int.parse(_currentInput);
        }
        return;
      }

      // so thu 2
      int num2 = int.parse(_currentInput);
      if (_operator == '+') {
        _result += num2;
      }
      _currentInput = '';
      _displayText = _result.toString();
    });
  }
}

class CalButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor = Colors.white;
  final VoidCallback? onPressed;
  const CalButton({
    super.key,
    required this.text,
    this.bgColor = Colors.black,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          shape: CircleBorder(),
          elevation: 3.0,

          // padding: const EdgeInsets.all(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
