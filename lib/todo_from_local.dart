import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
class MyTodolist extends StatefulWidget {
  const MyTodolist({super.key});

  @override
  State<MyTodolist> createState() => _MyTodolistState();
}

Future<List<Todo>> loadingData() async {
  await Future.delayed(
    const Duration(seconds: 2),
  );

  String jsonData = await rootBundle.loadString('assets/todo.json');
  List<dynamic> jsonList = jsonDecode(jsonData);
  List<Todo> todos = jsonList
      .map((json) => Todo(
            task: json['task'],
            isDone: json['isDone'],
          ))
      .toList();

  return todos;
}
Future<List<Todo>> LoadingDataFromUrl() async {
  await Future.delayed(
    const Duration(seconds: 2),
  );

  String jsonData = await rootBundle.loadString('assets/todo.json');

  final url = Uri.parse('https://dummyjson.com/c/562b-f00f-4082-9583');
final response = await http.get(url);
if (response.statusCode == 200){
  jsonData = response.body;
} else{throw Exception('Failed to load data');}
  List<dynamic> jsonList = jsonDecode(jsonData);
  List<Todo> todos = jsonList
      .map((json) => Todo(
            task: json['task'],
            isDone: json['isDone'],
          ))
      .toList();

  return todos;
}
class _MyTodolistState extends State<MyTodolist> {
  late Future<List<Todo>> futureTodoList;

  void initState() {
    super.initState();
    futureTodoList = loadingData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: FutureBuilder(
            future: loadingData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return const LoadingBar();
              else {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else {
                  final todos = snapshot.data;
                  return ListView.builder(
                      itemCount: todos!.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(todos![index].task),
                          value: todos[index].isDone,
                          onChanged: (value) {
                            setState(() {
                              todos[index].isDone = value!;
                            });
                          },
                        );
                      });
                }
                return Text('Loading data done: ${snapshot.connectionState}');
              }
            }),
      ),
    );
  }
}

class LoadingBar extends StatelessWidget {
  const LoadingBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class Todo {
  String task;
  bool isDone;
  Todo({
    required this.task,
    this.isDone = false,
  });
}
