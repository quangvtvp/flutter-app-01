// import 'dart:math';

// import 'package:flutter/material.dart';

// class TuDien {
//   final String tuTiengAnh;
//   final String tuTiengViet;

//   TuDien({required this.tuTiengAnh, required this.tuTiengViet});
// // ignore: empty_constructor_bodies
// }

// class TuDienApp extends StatelessWidget {
//   const TuDienApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home:FlashcardScreen(),
//     );
//   }
// }

// class FlashcardScreen extends StatefulWidget {
//   const FlashcardScreen({super.key, required Center child});

//   @override
//   // ignore: library_private_types_in_public_api
//   _FlashcardScreenState createState() => _FlashcardScreenState();
// }

// class _FlashcardScreenState extends State<FlashcardScreen> {
//   final List<TuDien> vocabularyList = [
//     TuDien(tuTiengAnh: "apple", tuTiengViet: "quả táo"),
//     TuDien(tuTiengAnh: "banana", tuTiengViet: "quả chuối"),
//     TuDien(tuTiengAnh: "cat", tuTiengViet: "con mèo"),
//     TuDien(tuTiengAnh: "dog", tuTiengViet: "con chó"),
//     TuDien(tuTiengAnh: "elephant", tuTiengViet: "con voi"),
//     TuDien(tuTiengAnh: "fish", tuTiengViet: "con cá"),
//     TuDien(tuTiengAnh: "grape", tuTiengViet: "quả nho"),
//     TuDien(tuTiengAnh: "house", tuTiengViet: "ngôi nhà"),
//     TuDien(tuTiengAnh: "ice", tuTiengViet: "nước đá"),
//     TuDien(tuTiengAnh: "jungle", tuTiengViet: "rừng"),
//   ];

//   int currentIndex = 0;
//   bool showMeaning = false;

//   void changeWord() {
//     setState(() {
//       currentIndex = Random().nextInt(vocabularyList.length);
//       showMeaning = false;
//     });
//   }

//   void flipCard() {
//     setState(() {
//       showMeaning = !showMeaning;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     TuDien currentWord = vocabularyList[currentIndex];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Flashcard Từ Vựng"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 250,
//               height: 150,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     // ignore: deprecated_member_use
//                     color: Colors.white.withOpacity(0.5),
//                     spreadRadius: 3,
//                     blurRadius: 5,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               alignment: Alignment.center,
//               child: Text(
//                 showMeaning ? currentWord.tuTiengViet : currentWord.tuTiengAnh,
//                 style:
//                     const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: flipCard,
//               child: Text(showMeaning ? "Ẩn" : "Xem"),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: changeWord,
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//               child:
//                   const Text("Đổi từ", style: TextStyle(color: Colors.white)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
