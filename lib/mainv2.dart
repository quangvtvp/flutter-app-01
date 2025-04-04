import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<Student> students = [];

  String data = await rootBundle.loadString('assets/student_list.json');

  List<dynamic> json = jsonDecode(data);

  for (var item in json) {
    Student student = Student(name: item['name'], score: item['score']);
    students.add(student);
  }
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(students[index].name),
                  subtitle: Text('Diem so: ${students[index].score}'),
                  leading: Text('$index'),
                  trailing: const Icon(Icons.arrow_forward),
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}

class Student {
  final String name;
  final String score;

  Student({required this.name, required this.score});
}
