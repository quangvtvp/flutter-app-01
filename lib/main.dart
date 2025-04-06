import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that you can use
  WidgetsFlutterBinding.ensureInitialized();
  String chatJson = await rootBundle.loadString('assets/newchat.json');
  String todo = await rootBundle.loadString('assets/todo.json');
  List<dynamic> jsonChat = jsonDecode(chatJson);
  List<dynamic> jsonTodo = jsonDecode(todo);
  List<Chat> chats = [];
  List<Todo> todos = [];
  for (var item in jsonChat) {
    Chat chat = Chat.fromJson(item);
    chats.add(chat);
  }
  for (var item in jsonTodo) {
    Todo todo = Todo.fromJson(item);
    todos.add(todo);
  }
  runApp(MyTodoApp(
    todos: todos,
  ));
}

class MyChatApp extends StatefulWidget {
  final List<Chat> chats;
  const MyChatApp({super.key, required this.chats});

  @override
  State<MyChatApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyChatApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  setState(() {
                    widget.chats[index].isRead = false;
                  });
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.chats[index].avatar),
                ),
                title: Text(widget.chats[index].name),
                trailing: widget.chats[index].isRead
                    ? const Icon(Icons.messenger, color: Colors.green)
                    : const Icon(Icons.messenger, color: Colors.grey),
              );
            },
            itemCount: widget.chats.length),
      ),
    );
  }
}

class MyTodoApp extends StatefulWidget {
  final List<Todo> todos;
  const MyTodoApp({super.key, required this.todos});

  @override
  State<MyTodoApp> createState() => _MyTodoAppState();
}

class _MyTodoAppState extends State<MyTodoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    setState(() {
                      widget.todos[index].isDone = !widget.todos[index].isDone;
                    });
                  },
                  leading: Checkbox(
                    value: widget.todos[index].isDone,
                    onChanged: (value) {
                      setState(() {
                        widget.todos[index].isDone = value!;
                      });
                    },
                  ),
                  title: Text(widget.todos[index].name),
                );
              },
              itemCount: widget.todos.length)),
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
