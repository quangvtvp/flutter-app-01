import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // new import
// ignore: depend_on_referenced_packages
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
 await Supabase.initialize(
      url: 'https://dbhwiwngltxrbuasrilt.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRiaHdpd25nbHR4cmJ1YXNyaWx0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU3NTc2MzgsImV4cCI6MjA2MTMzMzYzOH0.OSwLzj3L2u4r9_WiFDFimLUdNw3RImF0jlkMCvgAUPw',);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
    futureTodoList = loadTodoFromNetwork();
  }

  // Load JSON from network
  Future<List<TodoItem>> loadTodoFromNetwork() async {
    final url = Uri.parse('https://dummyjson.com/c/562b-f00f-4082-9583');
    // Send HTTP GET request
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Decode JSON response
      final List decodedJson = jsonDecode(response.body);
      // Map to model
      return decodedJson.map((e) => TodoItem.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load to-do list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List - From Network')),
      body: FutureBuilder<List<TodoItem>>(
        future: futureTodoList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
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
