import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('message'),
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
