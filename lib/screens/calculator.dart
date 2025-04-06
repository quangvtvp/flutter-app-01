import 'package:flutter/material.dart';
// import 'dart:math'; // Not strictly needed anymore

void main() {
  runApp(CalculatorApp());
}

// --- Widget gốc của ứng dụng ---
class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: CalculatorScreen(),
    );
  }
}

// --- Màn hình chính của máy tính (Stateful) ---
class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

// --- State của màn hình chính ---
class _CalculatorScreenState extends State<CalculatorScreen> {
  // --- State Variables (Simplified) ---
  String _display = "0";        // Chuỗi hiển thị trên màn hình
  String _currentInput = "";    // Số nguyên dương đang được nhập
  int _operand1 = 0;          // Toán hạng đầu tiên (số nguyên)
  String _operator = "";        // Toán tử đang chờ (+, -, x, ÷)
  bool _waitingForOperand = true; // Cờ: true nếu đang chờ nhập số mới (sau AC, toán tử, =)

  // --- Constants for checks ---
  static const String _digits = '0123456789';
  static const String _operators = '+-x÷';

   // --- Helper function to check if a string ends with an operator ---
   bool _endsWithOperator(String text) {
      if (text.isEmpty) return false;
      // Check if the last character is one of the operators
      return _operators.contains(text[text.length - 1]);
   }

  // --- Button Press Handler ---
  void _onButtonPressed(String buttonText) {
    setState(() {
      if (_digits.contains(buttonText)) {
        // --- Xử lý nút số ---
        if (_display == "Error") return; // Không làm gì nếu đang lỗi

        if (_waitingForOperand) {
          _currentInput = buttonText; // Bắt đầu số mới
          _waitingForOperand = false; // Đã bắt đầu nhập
        } else {
           // Chỉ nối số nếu chưa quá dài (ví dụ: 9 chữ số)
           if (_currentInput.length < 9) {
               // Xử lý trường hợp nhập số 0 ở đầu
               if (_currentInput == "0") {
                   _currentInput = buttonText;
               } else {
                  _currentInput += buttonText;
               }
           }
        }
        // Cập nhật hiển thị: Luôn hiển thị số đang nhập
        _display = _currentInput;

      } else if (_operators.contains(buttonText)) {
        // --- Xử lý nút toán tử ---
        if (_display == "Error") return;

        // Thực hiện phép tính trước đó nếu có đủ thông tin
        _performCalculation();

        // Lưu toán tử mới và chuẩn bị cho toán hạng tiếp theo
        if (_display != "Error") { // Chỉ lưu nếu không có lỗi sau phép tính trước
            _operator = buttonText;
            _waitingForOperand = true;
            // Hiển thị kết quả của phép tính trước đó (nếu có) hoặc toán hạng 1
             _display = _operand1.toString(); // Hiển thị operand1 (là kết quả cũ hoặc số đầu tiên)
        }

      } else if (buttonText == '=') {
        // --- Xử lý nút bằng ---
        if (_display == "Error") return;

        if (_operator.isNotEmpty) { // Chỉ tính khi có toán tử chờ
             _performCalculation();
             _operator = ""; // Reset toán tử sau khi nhấn bằng
             _waitingForOperand = true; // Chờ phép tính mới hoặc số mới
             // _currentInput = ""; // Reset current input
        }

      } else if (buttonText == 'AC') {
        // --- Xử lý nút AC ---
        _display = "0";
        _currentInput = "";
        _operand1 = 0;
        _operator = "";
        _waitingForOperand = true;

      }
      // --- Các nút bị vô hiệu hóa logic ---
      // else if (buttonText == '.') {
      //   // Logic dấu thập phân bị loại bỏ
      // }
      // else if (buttonText == '+/-') {
      //   // Logic +/- bị loại bỏ
      // }
      // else if (buttonText == '%') {
      //   // Logic % bị loại bỏ
      // }
    });
  }

  // --- Hàm thực hiện tính toán tuần tự (Simplified for Integers) ---
  void _performCalculation() {
    // Chỉ thực hiện nếu có toán tử chờ và số hiện tại không rỗng
    if (_operator.isEmpty || _currentInput.isEmpty) {
        // Nếu không có số hiện tại nhưng có toán tử (ví dụ nhấn 5 + -)
        // -> không làm gì hoặc xử lý thay đổi toán tử (đã xử lý phần nào ở trên)
        // Nếu không có toán tử -> lưu số hiện tại vào operand1
        if (_operator.isEmpty && _currentInput.isNotEmpty) {
            try {
                _operand1 = int.parse(_currentInput);
            } catch (e) {
                _display = "Error";
                _resetOnError();
            }
        }
        return;
    }


    try {
      int operand2 = int.parse(_currentInput); // Toán hạng thứ 2 là số vừa nhập

      // Thực hiện phép tính
      switch (_operator) {
        case '+':
          _operand1 += operand2;
          break;
        case '-':
          _operand1 -= operand2;
          break;
        case 'x':
          _operand1 *= operand2;
          break;
        case '÷':
          if (operand2 == 0) {
            _display = "Error"; // Lỗi chia cho 0
            _resetOnError();
            return;
          }
          // Sử dụng phép chia lấy phần nguyên
          _operand1 = _operand1 ~/ operand2;
          break;
      }

      // Sau khi tính toán, kết quả nằm trong _operand1
      _display = _operand1.toString(); // Hiển thị kết quả
      _currentInput = ""; // Reset số đang nhập
      // Giữ _operator nếu người dùng nhấn toán tử tiếp -> tính liên tiếp
      // _operator sẽ được reset nếu nhấn = hoặc AC

    } catch (e) {
      _display = "Error"; // Lỗi nếu không parse được số
      _resetOnError();
    }
  }

  // --- Hàm định dạng kết quả (Simplified) ---
  // Không cần thiết vì đã dùng int và toString() trực tiếp

  // --- Hàm dọn dẹp chuỗi hiển thị (Simplified) ---
  String _sanitizeDisplay(String display) {
      // Chỉ cần đảm bảo không phải là Error hoặc rỗng
      if (display == "Error" || display.isEmpty) return "0";
      return display;
  }


  // --- Hàm reset state khi có lỗi ---
  void _resetOnError() {
    // Giữ nguyên _display = "Error"
    _currentInput = "";
    _operand1 = 0;
    _operator = "";
    _waitingForOperand = true;
  }


  // --- Helper Widget to build buttons consistently (Giữ nguyên) ---
  Widget _buildButton(String text, {int flex = 1}) {
    Color bgColor;
    Color textColor = Colors.white;
    bool isEnabled = true; // Mặc định là bật

    // Xác định màu và trạng thái bật/tắt
    if (_operators.contains(text) || text == '=') {
      bgColor = Colors.orange;
    } else if (text == 'AC') {
      bgColor = Colors.grey;
    } else if (_digits.contains(text)){
      bgColor = Color(0xFF333333);
    } else {
      // Các nút bị vô hiệu hóa logic ('.', '+/-', '%')
      bgColor = Colors.grey.withOpacity(0.5); // Làm mờ đi
      textColor = Colors.white.withOpacity(0.5);
      isEnabled = false; // Đặt là không được kích hoạt
    }

    return Expanded(
      flex: flex,
      child: CalculatorButton(
        text: text,
        backgroundColor: bgColor,
        textColor: textColor,
        // Chỉ gọi _onButtonPressed nếu nút được bật
        onPressed: isEnabled ? () => _onButtonPressed(text) : () {},
      ),
    );
  }

  // --- Build Method: Creates the UI (Giữ nguyên cấu trúc) ---
  @override
  Widget build(BuildContext context) {
    double fontSize = 60.0;
    // Điều chỉnh font size nếu cần (có thể bỏ nếu chỉ là số nguyên)
    if (_display.length > 9) {
        fontSize = 40.0;
    }
    if (_display.length > 14) {
        fontSize = 30.0;
    }


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Display Area
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.black,
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: SelectableText(
                  _display, // Hiển thị số/kết quả/lỗi
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  scrollPhysics: NeverScrollableScrollPhysics(),
                  minLines: 1,
                ),
              ),
            ),
            // Button Area
            Expanded(
              flex: 5,
              child: Column(
                children: <Widget>[
                  // Rows of buttons
                  Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [_buildButton("AC"), _buildButton("+/-"), _buildButton("%"), _buildButton("÷")])),
                  Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [_buildButton("7"), _buildButton("8"), _buildButton("9"), _buildButton("x")])),
                  Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [_buildButton("4"), _buildButton("5"), _buildButton("6"), _buildButton("-")])),
                  Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [_buildButton("1"), _buildButton("2"), _buildButton("3"), _buildButton("+")])),
                  Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [_buildButton("0", flex: 2), _buildButton("."), _buildButton("=")])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// --- Reusable Calculator Button Widget (Giữ nguyên) ---
class CalculatorButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  final double fontSize;

  CalculatorButton({
    required this.text,
    required this.backgroundColor,
    this.textColor = Colors.white,
    required this.onPressed,
    this.fontSize = 28.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: ElevatedButton(
            onPressed: onPressed, // onPressed được truyền vào
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: textColor,
              shape: CircleBorder(),
              padding: EdgeInsets.all(constraints.maxWidth * 0.15),
              elevation: 3.0,
            ),
            child: FittedBox(
               fit: BoxFit.scaleDown,
               child: Text(
                  text,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
               ),
            ),
          ),
        );
      },
    );
  }
}
