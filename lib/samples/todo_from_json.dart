import 'dart:convert'; // for jsonDecode
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for rootBundle

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late Future<List<TodoItem>> futureTodoList;

  @override
  void initState() {
    super.initState();
    futureTodoList = loadTodoFromAssets();
  }

  // Load JSON from local asset
  Future<List<TodoItem>> loadTodoFromAssets() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    // Read file as String
    final jsonString = await rootBundle.loadString('assets/todo.json');
    // Convert JSON String to List
    final List<dynamic> decodedJson = jsonDecode(jsonString) as List<dynamic>;
    // Map each item to TodoItem
    return decodedJson.map((e) => TodoItem.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List - From Assets'),
      ),
      body: FutureBuilder<List<TodoItem>>(
        future: futureTodoList,
        builder: (context, snapshot) {
          // Check connection state loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
            // Check if error
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Data is ready
            final todoList = snapshot.data!;
            return ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                final todo = todoList[index];
                return CheckboxListTile(
                  title: Text(todo.task),
                  value: todo.isDone,
                  onChanged: (newValue) {
                    setState(() {
                      todo.isDone = newValue!;
                    });
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

// Simple model class
class TodoItem {
  int id;
  String task;
  bool isDone;

  TodoItem({
    required this.id,
    required this.task,
    required this.isDone,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'],
      task: json['task'],
      isDone: json['isDone'],
    );
  }
}
