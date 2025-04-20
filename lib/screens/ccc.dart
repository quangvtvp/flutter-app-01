import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const CalculatorScreen(),
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
  String _displayString = '0';
  String? _operand1;
  String? _operator;
  bool _isEnteringSecondOperand = false;

  // === Hàm xử lý logic khi nhấn nút ===
  void _handleButtonPress(String text) {
    setState(() {
      if (int.tryParse(text) != null) {
        // Xử lý nút SỐ
        if (_isEnteringSecondOperand) {
          _displayString = text;
          _isEnteringSecondOperand = false;
        } else {
          if (_displayString == '0') {
            _displayString = text;
          } else {
            if (_displayString.length < 9) {
              _displayString += text;
            }
          }
        }
      } else if (text == 'AC') {
        // Xử lý nút AC
        _displayString = '0';
        _operand1 = null;
        _operator = null;
        _isEnteringSecondOperand = false;
      } else if (['+', '-'].contains(text)) {
        // Xử lý nút TOÁN TỬ (+, -)
        if (_operand1 == null) {
          _operand1 = _displayString;
          _operator = text;
          _isEnteringSecondOperand = true;
        }
        // Logic phức tạp hơn (chuỗi phép tính, thay đổi toán tử) có thể thêm ở đây
      } else if (text == '=') {
        // Xử lý nút BẰNG
        if (_operand1 != null && _operator != null && !_isEnteringSecondOperand) {
          _calculate();
          // Giữ lại kết quả trên màn hình, nhưng reset trạng thái phép tính
          _operand1 = null;
          _operator = null;
          // _isEnteringSecondOperand = false; // Không cần thiết vì _calculate không set nó
        }
      }
      // TODO: Handle '.', '+/-', '%', 'x', '÷' in future improvements
    });
  }

  // === Hàm thực hiện phép tính ===
  void _calculate() {
    final double num1 = double.tryParse(_operand1!) ?? 0.0;
    final double num2 = double.tryParse(_displayString) ?? 0.0;
    double result = 0.0;

    if (_operator == '+') {
      result = num1 + num2;
    } else if (_operator == '-') {
      result = num1 - num2;
    } // TODO: Add 'x' and '÷' cases

    // Chuyển kết quả về String
    if (result == result.toInt()) {
      _displayString = result.toInt().toString();
    } else {
      _displayString = result.toString();
    }

    if (_displayString.length > 9) {
      // Cố gắng làm tròn thay vì dùng số mũ nếu có thể
      _displayString = result.toStringAsFixed(3);
      // Nếu vẫn quá dài sau khi làm tròn, mới dùng số mũ
      if (_displayString.length > 9) {
        _displayString = result.toStringAsExponential(3);
      }
    }
  }

  // Hàm tạo nút (Không thay đổi từ Nhiệm vụ 5)
  Widget _buildButton(String buttonText, {Color? buttonColor, int flex = 1, required VoidCallback onPressed}) {
    Color finalButtonColor;
    Color finalTextColor = Colors.white;

    if (['AC', '+/-', '%'].contains(buttonText)) {
      finalButtonColor = Colors.grey;
      finalTextColor = Colors.black;
    } else if (['÷', 'x', '-', '+', '='].contains(buttonText)) {
      finalButtonColor = Colors.orange;
    } else {
      finalButtonColor = const Color(0xFF333333);
    }

    if (buttonColor != null) {
      finalButtonColor = buttonColor;
    }

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: finalButtonColor,
            foregroundColor: finalTextColor,
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
          ),
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Khu vực hiển thị (Không đổi từ N5)
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  _displayString,
                  style: const TextStyle(fontSize: 72.0, fontWeight: FontWeight.w300, color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // Khu vực bàn phím (Chỉ thay đổi onPressed)
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _buildButton('AC', onPressed: () => _handleButtonPress('AC')),
                          _buildButton('+/-', onPressed: () => _handleButtonPress('+/-')), // Chưa xử lý
                          _buildButton('%', onPressed: () => _handleButtonPress('%')), // Chưa xử lý
                          _buildButton('÷', onPressed: () => _handleButtonPress('÷')), // Chưa xử lý
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _buildButton('7', onPressed: () => _handleButtonPress('7')),
                          _buildButton('8', onPressed: () => _handleButtonPress('8')),
                          _buildButton('9', onPressed: () => _handleButtonPress('9')),
                          _buildButton('x', onPressed: () => _handleButtonPress('x')), // Chưa xử lý
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _buildButton('4', onPressed: () => _handleButtonPress('4')),
                          _buildButton('5', onPressed: () => _handleButtonPress('5')),
                          _buildButton('6', onPressed: () => _handleButtonPress('6')),
                          _buildButton('-', onPressed: () => _handleButtonPress('-')),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _buildButton('1', onPressed: () => _handleButtonPress('1')),
                          _buildButton('2', onPressed: () => _handleButtonPress('2')),
                          _buildButton('3', onPressed: () => _handleButtonPress('3')),
                          _buildButton('+', onPressed: () => _handleButtonPress('+')),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _buildButton('0', flex: 2, onPressed: () => _handleButtonPress('0')),
                          _buildButton('.', onPressed: () => _handleButtonPress('.')), // Chưa xử lý
                          _buildButton('=', onPressed: () => _handleButtonPress('=')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
