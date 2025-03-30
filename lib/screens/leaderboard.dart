import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> topUsers = [
      {"name": "John Deh", "score": "8/10", "image": "assets/john.jpg"},
      {"name": "David James", "score": "9/10", "image": "assets/david.jpg"},
      {"name": "Michael", "score": "7/10", "image": "assets/michael.jpg"},
    ];

    List<Map<String, dynamic>> otherUsers = [
      {
        "rank": 4,
        "name": "Smith Carol",
        "score": "6/10",
        "image":
            "https://image.nhandan.vn/w800/Files/Images/2022/03/24/Cristiano_Ronaldo_4-1648112600825.jpeg.webp"
      },
      {
        "rank": 5,
        "name": "Harry",
        "score": "5/10",
        "image":
            "https://image.nhandan.vn/w800/Files/Images/2022/03/24/Cristiano_Ronaldo_4-1648112600825.jpeg.webp"
      },
      {
        "rank": 6,
        "name": "Jon",
        "score": "4/10",
        "image":
            "https://image.nhandan.vn/w800/Files/Images/2022/03/24/Cristiano_Ronaldo_4-1648112600825.jpeg.webp"
      },
      {
        "rank": 7,
        "name": "Ken",
        "score": "3/10",
        "image":
            "https://image.nhandan.vn/w800/Files/Images/2022/03/24/Cristiano_Ronaldo_4-1648112600825.jpeg.webp"
      },
      {
        "rank": 8,
        "name": "Petter",
        "score": "2/10",
        "image":
            "https://image.nhandan.vn/w800/Files/Images/2022/03/24/Cristiano_Ronaldo_4-1648112600825.jpeg.webp"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("Leaderboard"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildTopThree(topUsers),
          Expanded(
            child: ListView.builder(
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

  Widget _buildTopThree(List<Map<String, dynamic>> users) {
    return Container(
      height: 220,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(100, 142, 139, 1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTopUser(users[0], 60, 3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildTopUser(users[1], 80, 1, isChampion: true),
          ),
          _buildTopUser(users[2], 60, 2),
        ],
      ),
    );
  }

  Widget _buildTopUser(Map<String, dynamic> user, double size, int rank,
      {bool isChampion = false}) {
    return Column(
      mainAxisAlignment:
          isChampion ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: size / 2,
              backgroundImage: NetworkImage(
                  "https://image.nhandan.vn/w800/Files/Images/2022/03/24/Cristiano_Ronaldo_4-1648112600825.jpeg.webp"),
            ),
            if (isChampion)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.yellow,
                  border: Border.all(color: Colors.yellow, width: 3),
                ),
                child: CircleAvatar(
                  radius: size / 2 + 5,
                  backgroundImage: NetworkImage(
                      "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTuqmrx5e_mLUJdFRMBSjfvojvWtGs8th027w_2GVvqouy6dkr_MbHORDgV0GTq-PlKuqfFlhjJi1iIziGq9Rc2ag"),
                ),
              ),
          ],
        ),
        const SizedBox(height: 5),
        Text(user["name"], style: const TextStyle(color: Colors.white)),
        Text(user["score"], style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _buildUserTile(Map<String, dynamic> user) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Text(user["rank"].toString(),
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(user["image"]),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Text(user["name"], style: const TextStyle(fontSize: 16))),
          Text(user["score"],
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
