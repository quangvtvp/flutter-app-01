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
      home: Scaffold(
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
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(students[index].name),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(students[index].avatar),
                      ),
                      trailing: Icon(Icons.messenger_sharp,
                          color: students[index].isRead
                              ? Colors.green
                              : Colors.grey),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class Student {
  final String name;
  final bool isRead;
  final String avatar;

  Student({required this.isRead, required this.avatar, required this.name});
}
