// ignore: file_names
import 'package:flutter/material.dart';

class Card1 extends StatelessWidget {
  const Card1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card'),
      ),
      
      body: 
        
       Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15), // Bo góc Card
  ),
  elevation: 5, // Hiệu ứng đổ bóng
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "New York, NY",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.yellow, // Màu nền vàng
          ),
          
        ),
        const SizedBox(height: 10),
        
            const Text(
              "30°", // Hiển thị nhiệt độ bên trong hình tròn
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          
        Text(
          "Mostly sunny",
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    ),
  ),
),);



  }
  
}


