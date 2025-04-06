import 'package:flutter/material.dart';

void main() {
  List<Student> students = [
    Student(name: "Nguyen Van A", score: "10"),
    Student(name: "Nguyen Van B", score: "8")
  ];
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: ListView.builder(
            itemCount: students.length,
            itemBuilder: (Contex, index) {
              return Card(
                child: ListTile(
                  title: Text(students[index].name),
                  subtitle: Text(students[index].score),
                  leading: Text('$index'),
                  trailing: Icon(Icons.arrow_back),
                ),
              );
            }),
      ),
    ),
  ));
}

class Student {
  final String name;
  final String score;

  Student({required this.name, required this.score});
}
