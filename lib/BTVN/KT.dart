import 'package:flutter/material.dart';

class TodoList_app extends StatelessWidget {
  const TodoList_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 1,
                child: AppBar(
                  backgroundColor: Colors.green,
                  title: Center(
                    child: Text(
                      'New Chat',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
            Expanded(flex: 20, child: Center(child: _My_TodoList()))
          ],
        ),
      ),
    );
  }
}

class _My_TodoList extends StatefulWidget {
  const _My_TodoList({super.key});

  @override
  State<_My_TodoList> createState() => _My_todoListState();
}

class _My_todoListState extends State<_My_TodoList> {
  Map<dynamic, dynamic> list = {'ban1': 'icon1', 'ban2': 'icon2'};
  List<String> name = ['ban1', 'ban2', 'ban3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text('Recent Chat'),
          SizedBox(
            width: 20,
            height: 20,
          ),
          for (var i in name) list[i] != null ? Text(list[i]) : Text('')
        ],
      ),
    );
  }
}
