import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class MyTodoList extends StatefulWidget {
  const MyTodoList({super.key});

  @override
  State<MyTodoList> createState() => _MyTodoListState();
}

// ignore: non_constant_identifier_names

// ignore: non_constant_identifier_names
Future<List<Todo>> LoadingDataFromUr() async {
  await Future.delayed(const Duration(seconds: 2), () {});

  final url = Uri.parse('https://dummyjson.com/c/562b-f00f-4082-9583');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    String jsonData = response.body;
    List<dynamic> jsonList = jsonDecode(jsonData);
    List<Todo> todoList = jsonList
        .map((json) => Todo(
              task: json['task'],
              isDone: json['isDone'],
            ))
        .toList();
    return todoList;
  } else {
    throw Exception('Failed to load data');
  }
}

class _MyTodoListState extends State<MyTodoList> {
  late Future<List<Todo>> todoList;
  @override
  void initState() {
    super.initState();
    todoList = LoadingDataFromUr();
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
          future: todoList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingBar();
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final todoList = snapshot.data;
                return ListView.builder(
                  itemCount: todoList!.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                        title: Text(todoList[index].task),
                        value: todoList[index].isDone,
                        onChanged: (value) {
                          setState(() {
                            todoList[index].isDone = value!;
                          });
                        });
                  },
                );
              }
            }
          },
        ),
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
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class Todo {
  final String task;
  bool isDone;

  Todo({required this.task, required this.isDone});
}
