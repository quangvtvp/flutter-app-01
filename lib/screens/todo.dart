import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  List<Todo> Todolist = [];

  var s = await rootBundle.loadString('assets/todo.json');
  String data = s;

  List<dynamic> json = jsonDecode(data);

  for (var item in json) {
    Todo todos = Todo(id: item['id'], name: item['name']);
    Todolist.add(todos);
  }
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: ListView.builder(
            itemCount: Todolist.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(Todolist[index].name),
                  subtitle: Text(' ${Todolist[index].id}'),
                  leading: Text('$index'),
                  trailing: const Icon(Icons.arrow_forward),
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}

class Todo {
  final String id;
  final String name;

  Todo({required this.name, required this.id});
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
  // Danh sách task mặc định

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              itemBuilder: (context, index) {
                final task = Todo(name: 'name', id: 'id');
                return CheckboxListTile(
                  activeColor: Colors.purple,
                  title: Text(
                    task.id == 'completed'
                        ? '${task.name}'.strikeThrough()
                        : task.name,
                    style: TextStyle(
                      color: Colors.black,
                      decoration: task.id == 'completed'
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  value: task.id == 'completed',
                  onChanged: (bool? newValue) {
                    setState(() {
                      // Update logic for task completion
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
        onPressed: () {
          // Xử lý khi nhấn nút thêm mới
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
      ),
    );
  }
}

// Extension để tạo text strike-through
extension StringExtension on String {
  String strikeThrough() {
    return '$this';
  }
}
