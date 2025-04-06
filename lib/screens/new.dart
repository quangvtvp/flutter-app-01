import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTodoList();
  }

  Future<void> loadTodoList() async {
    final String response = await rootBundle.loadString('assets/todo.json');
    final List<dynamic> data = jsonDecode(response);
    setState(() {
      tasks = data.map((item) => Map<String, dynamic>.from(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Todo list')),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Thursday, 12 October',
            style: TextStyle(
              color: Colors.purple,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return CheckboxListTile(
                activeColor: Colors.purple,
                title: Text(
                  task['title'],
                  style: TextStyle(
                    decoration: task['completed']
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                value: task['completed'],
                onChanged: (bool? value) {
                  setState(() {
                    tasks[index]['completed'] = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              );
            },
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
      ),
    );
  }
}
