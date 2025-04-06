import 'package:flutter/material.dart';
import 'dart:convert';

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
  // Danh sách task
  List<Map<String, dynamic>> tasks = [];

  // Hàm đọc dữ liệu từ file JSON trong assets
  Future<void> loadTasksFromAssets() async {
    try {
      // Đọc nội dung file JSON từ assets
      String jsonData =
          await DefaultAssetBundle.of(context).loadString('assets/todo.json');
      setState(() {
        tasks = jsonDecode(jsonData);
      });
    } catch (e) {
      print('Lỗi khi đọc file JSON: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadTasksFromAssets(); // Gọi hàm đọc file JSON khi khởi tạo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo list'),
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
                color:Colors.purple,
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
                    task['isDone']
                        ? '${task['name']}'.strikeThrough()
                        : task['name'],
                    style: TextStyle(
                      decoration: task['isDone']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  value: task['isDone'],
                  onChanged: (bool? newValue) {
                    setState(() {
                      tasks[index]['isDone'] = newValue!;
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
        backgroundColor:Colors.purple,
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
