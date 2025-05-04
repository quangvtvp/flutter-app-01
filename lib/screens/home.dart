import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Mon Van'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Mon Hoa'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Mon Toan'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
