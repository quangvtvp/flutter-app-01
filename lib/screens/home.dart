import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: ListView(children: [
          ListTile(
            title: Text('môn văn'),
            onTap: () {},
          ),
          ListTile(
            title: Text('môn lịch sử'),
            onTap: () {},
          ),
          ListTile(
            title: Text('môn hóa học'),
            onTap: () {},
          ),
          ListTile(
            title: Text('môn tiếng anh'),
            onTap: () {},
          ),
        ]));
  }
}
