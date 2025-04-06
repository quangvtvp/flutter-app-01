import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import to read assets

// Student class to hold the student data
class Student {
  final String name;
  final String avatar;
  bool isRead;

  Student({required this.name, required this.avatar, this.isRead = false});
}

// Main TodoListApp widget
class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  Future<List<Student>> loadStudents() async {
    // Load the JSON file from assets
    String data = await rootBundle.loadString('assets/newchat.json');
    List<dynamic> json = jsonDecode(data);

    // Parse the data into a list of Student objects
    List<Student> students = [];
    for (var item in json) {
      Student student = Student(
        name: item['name'],
        avatar: item['avatar'],
        isRead:
            item['isRead'] ?? false, // Default isRead to false if not specified
      );
      students.add(student);
    }
    return students;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<List<Student>>(
        future: loadStudents(), // Load students asynchronously
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else if (snapshot.hasData) {
            return Home(students: snapshot.data!); // Pass the loaded students
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}

// Home widget that takes a list of students
class Home extends StatefulWidget {
  const Home({super.key, required this.students});

  final List<Student> students;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Chat'),
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
              style: TextStyle(fontWeight: FontWeight.w700),
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
                    trailing: Icon(
                      Icons.messenger_sharp,
                      color: widget.students[index].isRead
                          ? Colors.grey
                          : Colors.greenAccent,
                    ),
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

// Entry point of the application
