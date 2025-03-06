import 'package:flutter/material.dart';

class Student {
  final String name;
  final String date;
  

  Student({required this.name, required this.date, });
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List<Student> students = [
    Student(name: "Trần Viết Hoàng", date: "06/02/2007"),
    Student(name: "Đàm Đức Hải", date: "21/07/2007"),
    Student(name: "Nguyễn Thành Phong", date: "30/09/2007"),
  ];

  int sv = 0;

  void showNextStudent() {
    setState(() {
      sv = (sv + 1) % students.length; // Lấy sinh viên tiếp theo theo thứ tự
    });
  }

  @override
  Widget build(BuildContext context) {
    Student student = students[sv];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Screen"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person, // Thay thế ảnh bằng icon
              size: 100,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 20),
            Text(student.name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Ngày sinh: ${student.date}",
                style: TextStyle(fontSize: 18, color: Colors.grey[700])),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: showNextStudent,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text("Next "),
            ),
          ],
        ),
      ),
    );
  }
}
