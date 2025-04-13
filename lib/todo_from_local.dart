import 'package:flutter/material.dart';

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
  List<Todo> todos = [
    Todo(task: "learning dart", isDone: true),
    Todo(task: "learning flutter", isDone: false),
    Todo(task: "build an app", isDone: false),
  ];
  return todos;
}

class _MyTodoListState extends State<MyTodoList> {
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
