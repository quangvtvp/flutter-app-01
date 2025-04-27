import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Todo {
  final int id;
  final String task;
  bool isDone;

  Todo({required this.id, required this.task, required this.isDone});

  // Factory method to create Todo from JSON
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      task: json['task'],
      isDone: json['isDone'],
    );
  }
}

class MyTodoList extends StatefulWidget {
  @override
  State<MyTodoList> createState() => _MyTodoListState();
}

Future<List<Todo>> loadingDataFromUrl() async {
  try {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // URL của file JSON trên internet
    final url = Uri.parse('https://dummyjson.com/c/562b-f00f-4082-9583');

    // Gửi yêu cầu HTTP GET
    final response = await http.get(url);

    // Kiểm tra trạng thái phản hồi
    if (response.statusCode == 200) {
      // Chuyển đổi chuỗi JSON thành danh sách đối tượng Todo
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data from the network');
    }
  } catch (e) {
    print("Error loading JSON: $e");
    return []; // Return an empty list if there's an error
  }
}

class _MyTodoListState extends State<MyTodoList> {
  late Future<List<Todo>> futureTodoList;

  @override
  void initState() {
    super.initState();
    futureTodoList = loadingDataFromUrl();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
          centerTitle: true, // Căn giữa tiêu đề
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: FutureBuilder<List<Todo>>(
          future: futureTodoList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingBar();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final todos = snapshot.data ?? [];
              if (todos.isEmpty) {
                return const Center(child: Text('No tasks available.'));
              }
              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    title: Text(todo.task),
                    trailing: Checkbox(
                      value: todo.isDone,
                      onChanged: (value) {
                        setState(() {
                          todo.isDone = value!;
                        });
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

// Widget LoadingBar
class LoadingBar extends StatelessWidget {
  const LoadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          const SizedBox(height: 16),
          const Text('Loading...'),
        ],
      ),
    );
  }
}
