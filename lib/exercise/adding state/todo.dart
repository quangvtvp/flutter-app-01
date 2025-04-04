import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final List<Todo> _todoList = [
    Todo(id: 1, text: 'Learn Dart', isDone: false),
    Todo(id: 2, text: 'Build a Flutter App', isDone: true),
    Todo(id: 2, text: 'Learn backend development', isDone: true),
    Todo(id: 2, text: 'Work out', isDone: true),
    Todo(id: 2, text: 'Practice english', isDone: true),
  ];

  void _toggleTodoStatus(int index) {
    setState(() {
      _todoList[index].isDone = !_todoList[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo list'),
        backgroundColor: Colors.deepPurple[400],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new todo functionality can be implemented here
        },
        backgroundColor: Colors.deepPurple[400],
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: const Text('Thursday, 12 October',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                )),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                final todo = _todoList[index];
                return ListTile(
                  leading: Checkbox(
                    value: todo.isDone,
                    onChanged: (_) => _toggleTodoStatus(index),
                  ),
                  title: Text(
                    todo.text,
                    style: TextStyle(
                      color: todo.isDone ? Colors.grey : Colors.black,
                      decoration:
                          todo.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Todo {
  final int id;
  final String text;
  bool isDone;

  Todo({
    required this.id,
    required this.text,
    this.isDone = false,
  });
}
