// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LeaderboardScreen(),
//     );
//   }
// }

// class User {
//   final int rank;
//   final String name;
//   final String score;

//   User({required this.rank, required this.name, required this.score});
// }

// List<User> users = [
//   User(rank: 4, name: "Smith Carol", score: "6/10"),
//   User(rank: 5, name: "Harry", score: "5/10"),
//   User(rank: 6, name: "Jon", score: "4/10"),
//   User(rank: 7, name: "Ken", score: "3/10"),
//   User(rank: 8, name: "Potter", score: "2/10"),
// ];

// class LeaderboardScreen extends StatelessWidget {
//   const LeaderboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Leaderboard'),
//       ),
//       body: Column(
//         children: [
//           _buildTopUser('Diesel', 'Line'),
//           _buildTopUser('Machin', 'Picture'),
//           Expanded(
//               child: ListView.builder(
//                   itemCount: users.length,
//                   itemBuilder: (context, index) {
//                     return _buildUserItem(users[index]);
//                   }))
//         ],
//       ),
//     );
//   }
// }

// Widget _buildTopUser(String name, String type) {
//   return Container(
//     padding: const EdgeInsets.all(16),
//     margin: const EdgeInsets.symmetric(vertical: 8),
//     decoration: BoxDecoration(
//       border: Border.all(color: Colors.grey),
//       borderRadius: BorderRadius.circular(8),
//     ),
//     child: Column(
//         children: [
//         Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         Text(type, style: TextStyle(color: Colors.grey[600])),
//       ],
//     ),
//   );
// }
