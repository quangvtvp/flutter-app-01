import 'package:flutter/material.dart';
import 'package:flutter_application/screens/welcome.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://sbcbalojhzxxvsmiainj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNiY2JhbG9qaHp4eHZzbWlhaW5qIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ1ODc1NzYsImV4cCI6MjA2MDE2MzU3Nn0.wtbHv7jlXhTIxfLQJ5JQFP1r3m5u_-13Cik87BMKL9Y',
  );
  runApp(MaterialApp(home: LoginScreen()));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

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
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Lỗi kết nối hoặc máy chủ: ${e.toString()}'
      };
    }
  }

  Future<Map<String, dynamic>> loginSupabase(
      String email, String password) async {
    try {
      final AuthResponse response =
          await Supabase.instance.client.auth.signInWithPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Kiểm tra nếu người dùng tồn tại trong phản hồi (đăng nhập thành công)
      if (response.user != null) {
        return {
          "success": true,
          "message": "Đăng nhập thành công!",
          // Giả sử 'username' ở đây là email của người dùng.
          // Tùy thuộc vào database schema của bạn, bạn có thể cần fetch profile để lấy username thật.
          "username": response.user!.email ?? "Người dùng",
        };
      } else {
        // Trường hợp đăng nhập không thành công nhưng không ném AuthException (hiếm gặp)
        return {
          "success": false,
          "message": "Đăng nhập thất bại: Thông tin không hợp lệ.",
        };
      }
    } on AuthException catch (e) {
      // Bắt các lỗi cụ thể từ Supabase Authentication
      return {
        "success": false,
        "message": "Lỗi đăng nhập: ${e.message}",
      };
    } catch (e) {
      // Bắt các lỗi chung khác
      return {
        "success": false,
        "message": "Đã xảy ra lỗi: ${e.toString()}",
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flashcard Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Đăng nhập',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  SizedBox(height: 32),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        labelText: 'Username', border: OutlineInputBorder()),
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
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscurePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập password';
                      }
                      if (value.length <= 5) {
                        return 'Password phải lớn hơn 5 ký tự';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          final result = await loginSupabase(
                            _usernameController.text,
                            _passwordController.text,
                          );
                          final bool success = result['success'] == true;
                          final String message = result['message'] ?? '';
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor:
                                  success ? Colors.green : Colors.red,
                            ),
                          );
                          if (success) {
                            Future.delayed(Duration(milliseconds: 600), () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => WelcomeScreen(),
                                ),
                              );
                            });
                          }
                        }
                      },
                      child: Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
