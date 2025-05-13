import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'vmpikbigyngdeogucwim.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZtcGlrYmlneW5nZGVvZ3Vjd2ltIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU3NTcwMDksImV4cCI6MjA2MTMzMzAwOX0.6v1G5BEWlZjOj1e3wfws4GRALc8BE46PHJLoIvHHwoQ',
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
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureTodoList =
        loadTodoFromSupabase(); // Load data from Supabase on initialization
  }

  // Fetch to-do list from Supabase
  Future<List<TodoItem>> loadTodoFromSupabase() async {
    try {
      final response = await Supabase.instance.client.from('todos').select();
      if (response.isNotEmpty) {
        return response.map((e) => TodoItem.fromJson(e)).toList();
      } else {
        throw Exception('No to-do items found in Supabase');
      }
    } catch (e) {
      print('Error loading to-do list from Supabase: $e');
      return loadTodoFromNetwork(); // Fallback to network if Supabase fails
    }
  }

  // Fetch JSON from network (for testing or fallback)
  Future<List<TodoItem>> loadTodoFromNetwork() async {
    final url = Uri.parse('');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List decodedJson = jsonDecode(response.body);
        return decodedJson.map((e) => TodoItem.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load to-do list from network');
      }
    } catch (e) {
      print('Error loading to-do list from network: $e');
      throw Exception('Failed to load to-do list from network: $e');
    }
  }

  // Update to-do item status in Supabase
  Future<void> updateTodo(TodoItem todo) async {
    try {
      await Supabase.instance.client
          .from('todos')
          .update({'isDone': todo.isDone}).eq('id', todo.id);
    } catch (e) {
      print('Error updating to-do item: $e');
    }
  }

  // Add a new to-do item to Supabase
  Future<void> addTodo(String task) async {
    try {
      final response = await Supabase.instance.client.from('todos').insert({
        'task': task,
        'isDone': false,
      }).execute();

      if (response.error != null) {
        throw Exception('Failed to add to-do item: ${response.error!.message}');
      }

      // Refresh the list after adding
      setState(() {
        futureTodoList = loadTodoFromSupabase();
      });
    } catch (e) {
      print('Error adding to-do item: $e');
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'An error occurred while loading the to-do list.',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Retry loading data
                      setState(() {
                        futureTodoList = loadTodoFromSupabase();
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            final todoList = snapshot.data!;
            if (todoList.isEmpty) {
              return const Center(
                child: Text('No tasks available.'),
              );
            }
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
          } else {
            return const Center(
              child: Text('No data available.'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            futureTodoList = loadTodoFromSupabase(); // Refresh data
          });
        },
        child: const Icon(Icons.refresh),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _taskController,
                decoration: const InputDecoration(
                  labelText: 'Enter a new task',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                if (_taskController.text.isNotEmpty) {
                  addTodo(_taskController.text);
                  _taskController.clear();
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

extension on PostgrestFilterBuilder {
  execute() {}
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
