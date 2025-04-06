import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> topUsers = [
      {"name": "Vu", "score": "8/10", "image": "assets/john.jpg"},
      {"name": "Ngoc", "score": "10/10", "image": "assets/david.jpg"},
      {"name": "Hoang", "score": "9/10", "image": "assets/michael.jpg"},
    ];

    List<Map<String, dynamic>> otherUsers = [
      {"rank": 4, "name": "hihi", "score": "6/10", "image": "assets/user1.jpg"},
      {"rank": 5, "name": "Haha", "score": "5/10", "image": "assets/user2.jpg"},
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 175, 188, 190),
      appBar: AppBar(
        title: const Text(
          "Leaderboard",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          _buildTopThree(topUsers),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                const Text(
                  "Other Participants",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 85, 6, 213).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      color: Color.fromARGB(255, 176, 25, 88),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: otherUsers.length,
              itemBuilder: (context, index) {
                return _buildUserTile(otherUsers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTile(Map<String, dynamic> user) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(user["image"]),
      ),
      title: Text(user["name"],
          style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(user["score"]),
      trailing: Text("#${user["rank"]}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTopThree(List<Map<String, dynamic>> users) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 109, 175, 218),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildTopUser(users[0], 60, 3),
          _buildTopUser(users[1], 80, 1, isChampion: true),
          _buildTopUser(users[2], 60, 2),
        ],
      ),
    );
  }

  Widget _buildTopUser(Map<String, dynamic> user, double size, int rank,
      {bool isChampion = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isChampion)
          const Icon(
            Icons.emoji_events,
            color: Colors.amber,
            size: 36,
          ),
        const SizedBox(height: 5),
        Stack(
          alignment: Alignment.center,
          children: [
            if (isChampion)
              Container(
                height: size + 10,
                width: size + 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color.fromARGB(255, 30, 24, 6), width: 3),
                ),
              ),
            CircleAvatar(
              radius: size / 2,
              backgroundImage: AssetImage(user["image"]),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: rank == 1
                      ? const Color.fromARGB(255, 194, 188, 169)
                      : rank == 2
                          ? Colors.grey[300]
                          : Colors.brown[300],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Text(
                  "#$rank",
                  style: TextStyle(
                    color: rank == 1 ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          user["name"],
          style: TextStyle(
            color: const Color.fromARGB(255, 96, 163, 75),
            fontWeight: isChampion ? FontWeight.bold : FontWeight.normal,
            fontSize: isChampion ? 16 : 14,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 29, 23, 23).withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            user["score"],
            style: const TextStyle(
              color: Color.fromARGB(255, 57, 38, 38),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
