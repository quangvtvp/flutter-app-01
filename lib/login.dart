import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(home: LoginScreen()));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true; // Biến để kiểm soát việc hiển thị/mất mật khẩu

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://us-central1-ict-app-7d697.cloudfunctions.net/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Lỗi kết nối hoặc máy chủ: ${e.toString()}'
      };
    }
  }

  void _handleLogin() async {
    // In ra giá trị của trường Password
    print('Password: ${_passwordController.text}');

    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      // Gọi hàm login để gửi yêu cầu đến API
      final result = await login(username, password);

      // In ra kết quả phản hồi từ API
      print(result.toString());

      // Kiểm tra trạng thái thành công và lấy thông báo
      final bool success = result['success'] == true;
      final String message = result['message'] ?? '';

      // Hiển thị thông báo với màu nền khác nhau
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );

      // Nếu đăng nhập thành công, chờ 600ms rồi chuyển sang WelcomeScreen
      if (success) {
        await Future.delayed(Duration(milliseconds: 600)); // Chờ 600ms
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Đăng nhập',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32.0),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập username';
                  }
                  if (value.contains(' ')) {
                    return 'Username không được chứa dấu cách';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                obscuringCharacter: '•',
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: _handleLogin,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

// Màn hình WelcomeScreen
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Khi logout, quay lại màn hình Login
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
