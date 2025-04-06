import 'package:flutter/material.dart';

class MynewChat extends StatefulWidget {
  const MynewChat({super.key});

  @override
  State<MynewChat> createState() => _MynewChatState();
}

class _MynewChatState extends State<MynewChat> {
  List<bool> isTappedList = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('New Chat'),
        backgroundColor: const Color.fromARGB(255, 77, 157, 6),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 77, 157, 6),
        child: const Icon(Icons.add_rounded),
      ),
      body: ListView(
        padding: const EdgeInsets.all(9),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 7),
            child: Text(
              'Recent chat',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildChatTile(
            imagePath: 'assets/anh1.jpg',
            name: 'Alex Nelson',
            index: 0,
          ),
          _buildChatTile(
            imagePath: 'assets/anh2.jpeg',
            name: 'Peter Carlsson',
            index: 1,
          ),
          _buildChatTile(
            imagePath: 'assets/anh3.jpg',
            name: 'Jane Doe',
            index: 2,
          ),
          _buildChatTile(
            imagePath: 'assets/anh4.jpeg',
            name: 'David Beckham',
            index: 3,
          ),
          _buildChatTile(
            imagePath: 'assets/anh5.jpeg',
            name: 'David Beckham',
            index: 4,
          ),
          _buildChatTile(
            imagePath: 'assets/anh6.jpeg',
            name: 'David Beckham',
            index: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile({
    required String imagePath,
    required String name,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 17),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(width: 12),
          // Tên người dùng
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Icon tin nhắn
          GestureDetector(
            onTap: () {
              setState(() {
                // Set Không phải tất cả các item còn lại về false và chỉ giữ lại true cho item hiện tại
                for (int i = 0; i < isTappedList.length; i++) {
                  if (i == index) {
                    isTappedList[i] = !isTappedList[i];
                  } else {
                    // isTappedList[i] = false;
                  }
                }
              });
            },
            child: Icon(
              Icons.messenger_sharp,
              color: isTappedList[index]
                  ? const Color.fromARGB(255, 67, 153, 24)
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
