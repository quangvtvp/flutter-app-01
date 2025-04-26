import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart'; // new import

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://plscfoyhyjzqmxmpqedc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBsc2Nmb3loeWp6cW14bXBxZWRjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU1OTUyMTcsImV4cCI6MjA2MTE3MTIxN30.Nu3LI2uETsHh2J2zqIs1-zn4xru1Cneq8bLkYHukikE',
  );
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
    futureTodoList = loadTodoFromSupabase();
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

  Future<List<TodoItem>> loadTodoFromSupabase() async {
    // Load JSON from Supabase
    final response = await Supabase.instance.client
        .from('todos')
        .select()
        .order('id', ascending: true);
    if (response.isNotEmpty) {
      return response.map((e) => TodoItem.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load to-do list from Supabase');
    }
  }

  Future<void> updateTodo(TodoItem todo) async {
    // Update todo in Supabase
    await Supabase.instance.client
        .from('todos')
        .update({'isDone': todo.isDone}).eq('id', todo.id);
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
                      updateTodo(todo);
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
