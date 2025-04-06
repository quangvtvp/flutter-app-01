import 'package:flutter/material.dart';

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
  // Danh sách task mặc định
  List<Map<String, dynamic>> tasks = [
    {'title': 'Learn UI design', 'completed': false},
    {'title': 'Build a Flutter App', 'completed': false},
    {'title': 'Learn backend development', 'completed': false},
    {'title': 'Work out', 'completed': false},
    {'title': 'Practice english', 'completed': false},
  ];

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
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return CheckboxListTile(
                  activeColor: Colors.purple,
                  title: Text(
                    task['completed']
                        ? '${task['title']}'.strikeThrough()
                        : task['title'],
                    style: TextStyle(
                      decoration: task['completed']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  value: task['completed'],
                  onChanged: (bool? newValue) {
                    setState(() {
                      tasks[index]['completed'] = newValue!;
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
