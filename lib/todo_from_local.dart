import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class MyTodoList extends StatefulWidget {
  const MyTodoList({super.key});

  @override
  State<MyTodoList> createState() => _MyTodoListState();
}

Future<List<Todo>> loadingData() async {
  // Simulate network delay
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

Future<List<Todo>> loadingDataFromUrl() async {
  // Simulate network delay
  await Future.delayed(
    const Duration(seconds: 2),
  );

  final url = Uri.parse('https://dummyjson.com/c/562b-f00f-4082-9583');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    String jsonData = response.body;
    List<dynamic> jsonList = jsonDecode(jsonData);
    List<Todo> todos = jsonList
        .map((json) => Todo(
              task: json['task'],
              isDone: json['isDone'],
            ))
        .toList();
    return todos;
  } else {
    throw Exception('Failed to load data');
  }
}

class _MyTodoListState extends State<MyTodoList> {
  late Future<List<Todo>> futureTodoList;

  @override
  void initState() {
    // TODO: implement initState
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
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: FutureBuilder(
            future: futureTodoList,
            builder: (context, snapshot) {
              // Check connection state loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingBar();
              } else {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else {
                  final todos = snapshot.data;
                  // check if todos is not null
                  return ListView.builder(
                    itemCount: todos!.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(todos[index].task),
                        value: todos[index].isDone,
                        onChanged: (value) {
                          setState(() {
                            todos[index].isDone = value!;
                          });
                        },
                      );
                    },
                  );
                }
                return Text("Loading data done: ${snapshot.connectionState}");
              }
              return Container();
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
