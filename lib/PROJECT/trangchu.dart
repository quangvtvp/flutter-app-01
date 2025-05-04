import 'package:flutter/material.dart';
import 'package:flutter_application/PROJECT/hoa.dart';
import 'package:flutter_application/PROJECT/su.dart';
import 'package:flutter_application/PROJECT/van.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Trang Chủ Học Sinh',
//       theme: ThemeData(primarySwatch: Colors.deepPurple),
//       home: const WelcomeScreen(),
//     );
//   }
// }

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ học sinh'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildSubjectButton(
                context, 'Môn Văn', Icons.menu_book, const MyVan()),
            _buildSubjectButton(
                context, 'Lịch sử', Icons.history_edu, const MySu()),
            _buildSubjectButton(
                context, 'Hóa học', Icons.science, const MyHoa()),
            _buildSubjectButton(context, 'Leaderboard', Icons.leaderboard,
                const MyVan()), // Có thể sửa sau
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectButton(
      BuildContext context, String label, IconData icon, Widget destination) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurpleAccent,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 10),
          Text(label,
              style: const TextStyle(fontSize: 16, color: Colors.white)),
        ],
      ),
    );
  }
}
