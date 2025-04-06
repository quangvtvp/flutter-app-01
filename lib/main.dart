import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that you can use
  WidgetsFlutterBinding.ensureInitialized();
  String chatJson = await rootBundle.loadString('assets/newchat.json');
  String todo = await rootBundle.loadString('assets/todo.json');
  List<Chat> chats = [];
  List<Todo> todos = [];
  (jsonDecode(chatJson) as List).map((e) {
    Chat chat = Chat.fromJson(e);
    chats.add(chat);
  });
  (jsonDecode(todo) as List).map((e) {
    Todo todo = Todo.fromJson(e);
    todos.add(todo);
  });
  print(chats);
  print(todos);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text("hello world"),
      ),
    );
  }
}

class Chat {
  String name;
  String avatar;
  bool isRead;

  Chat({
    required this.name,
    required this.avatar,
    required this.isRead,
  });
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      name: json['name'],
      avatar: json['avatar'],
      isRead: json['isRead'],
    );
  }
}

class Todo {
  String name;
  bool isDone;

  Todo({
    required this.name,
    required this.isDone,
  });
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      name: json['name'],
      isDone: json['isDone'],
    );
  }
}
