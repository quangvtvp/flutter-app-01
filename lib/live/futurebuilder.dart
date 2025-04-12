import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(
    const MaterialApp(
      home: MyWidget(),
    ),
  );
}

Future<List<Todo>> loadTodoFromAssets() async {
  // Simulate network delay
  await Future.delayed(const Duration(seconds: 2));
  String data = await rootBundle.loadString('assets/todo.json');
  List<dynamic> jsonData = jsonDecode(data);
  List<Todo> todos = jsonData.map((e) => Todo.fromJson(e)).toList();
  return todos;
}

Future<List<Todo>> loadTodoFromNetwork() async {
  final url = Uri.parse('https://dummyjson.com/c/562b-f00f-4082-9583');
  // Send HTTP GET request
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // Decode JSON response
    final List decodedJson = jsonDecode(response.body) as List<dynamic>;
    // Map to model
    List<Todo> todos = decodedJson.map((e) => Todo.fromJson(e)).toList();
    return todos;
  } else {
    throw Exception('Failed to load to-do list');
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    List<Todo> todos = [];

    return Scaffold(
        appBar: AppBar(
          title: const Text('FutureBuilder Example'),
        ),
        body: FutureBuilder(
          future: loadTodoFromNetwork(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingBar();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error loading data'),
              );
            } else if (snapshot.hasData) {
              todos = snapshot.data as List<Todo>;
              // Display the data
              return ListView.builder(
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(todos[index].task),
                    value: todos[index].isDone,
                    onChanged: (newValue) {
                      setState(() {
                        todos[index].isDone = newValue!;
                      });
                    },
                  );
                },
                itemCount: todos.length,
              );
            }
            return const Center(
              child: Text('No data available'),
            );
          },
        ));
  }
}

class LoadingBar extends StatelessWidget {
  const LoadingBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class Todo {
  int id;
  String task;
  bool isDone;

  Todo({
    required this.id,
    required this.task,
    required this.isDone,
  });
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      task: json['task'],
      isDone: json['isDone'],
    );
  }
}
