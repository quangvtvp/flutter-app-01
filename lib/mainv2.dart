import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<Student> students = [];

  String data = await rootBundle.loadString('assets/student_list.json');

  List<dynamic> json = jsonDecode(data);

  for (var item in json) {
    Student student = Student(
        name: item['name'], isRead: item['isRead'], avatar: item['avatar']);
    students.add(student);
  }
  runApp(
    MaterialApp(
      home: Home(students: students),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.students,
  });

  final List<Student> students;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Chat',
        ),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recent chat",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.students.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        widget.students[index].isRead = true;
                      });
                    },
                    onLongPress: () {
                      setState(() {
                        widget.students[index].isRead = false;
                      });
                    },
                    title: Text(widget.students[index].name),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.students[index].avatar),
                    ),
                    trailing: Icon(Icons.messenger_sharp,
                        color: widget.students[index].isRead
                            ? Colors.grey
                            : Colors.greenAccent),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Student {
  final String name;
  bool isRead;
  final String avatar;

  Student({required this.isRead, required this.avatar, required this.name});
}
