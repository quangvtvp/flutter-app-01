import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoListScreen(),
    );
  }
}

class TodoItem {
  final int id;
  final String name;
  bool isDone;

  TodoItem({required this.id, required this.name, required this.isDone});

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'],
      name: json['name'],
      isDone: json['isDone'],
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoItem> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTodoJson();
  }

  Future<void> loadTodoJson() async {
    final String response = await rootBundle.loadString('assets/todo.json');
    final List<dynamic> data = jsonDecode(response);
    setState(() {
      tasks = data.map((item) => TodoItem.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Todo list')),
        backgroundColor: const Color.fromARGB(255, 122, 11, 202),
        leading: const Icon(Icons.arrow_back),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Thursday, 12 October',
              style: TextStyle(
                color: Color.fromARGB(255, 112, 15, 154),
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
                  activeColor: const Color.fromARGB(255, 105, 14, 181),
                  title: Text(
                    task.name,
                    style: TextStyle(
                      decoration: task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  value: task.isDone,
                  onChanged: (bool? value) {
                    setState(() {
                      task.isDone = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 121, 7, 198),
        child: const Icon(Icons.add),
      ),
    );
  }
}
