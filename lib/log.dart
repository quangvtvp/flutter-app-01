import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: LoginScreen()));

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Flashcard Login')),
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
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập username';
                    }
                    if (value.contains(' ')) {
                      return 'Username không được chúa dấu cách';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(!_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập pw';
                    }
                    if (value.length <= 5) {
                      return 'Password phải lớn hơn 5 kí tự';
                    }
                    return null;
                  },
                  obscureText: _obscureText,
                  obscuringCharacter: 'x',
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    print('username: ' + _usernameController.text);
                    print('password:' + _passwordController.text);

                    _formKey.currentState!.validate();
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ));
  }
}
