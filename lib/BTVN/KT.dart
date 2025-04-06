import 'dart:convert';
import 'package:flutter/material.dart';

class MyJsonPage extends StatefulWidget {
  @override
  _MyJsonPageState createState() => _MyJsonPageState();
}

class _MyJsonPageState extends State<MyJsonPage> {
  // Dữ liệu JSON
  final String jsonString = '''[
  {
    "id": 1,
    "name": "Alex Nelson",
    "avatar": "https://m.media-amazon.com/images/S/pv-target-images/869079f492800cac2a3a310b9f1453caf0bb46a6ea6906cc0b9f8f0e6d3c0727._SX1080_FMjpg_.jpg",
    "isRead": true
  },
  {
    "id": 2,
    "name": "Peter Carlsson",
    "avatar": "https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/Cristiano_Ronaldo%2C_2023.jpg/250px-Cristiano_Ronaldo%2C_2023.jpg",
    "isRead": true
  },
  {
    "id": 3,
    "name": "Jane Doe",
    "avatar": "https://laban.edu.vn/wp-content/uploads/2024/02/11.2_Emma_Watson.jpg",
    "isRead": false
  },
  {
    "id": 4,
    "name": "David Beckham",
    "avatar": "https://images2.thanhnien.vn/528068263637045248/2024/3/3/david-beckham--1709462031579143310555.png",
    "isRead": false
  },
  {
    "id": 5,
    "name": "David Beckham",
    "avatar": "https://upload.wikimedia.org/wikipedia/commons/1/15/Andrea_Pirlo%2C_Save_the_Dream_at_the_Supercoppa_%28cropped%29.jpg",
    "isRead": false
  },
  {
    "id": 6,
    "name": "David Beckham",
    "avatar": "https://static.independent.co.uk/s3fs-public/thumbnails/image/2012/03/26/11/Del-Piero.jpg",
    "isRead": false
  }
  ]''';

  List<Map<String, dynamic>> jsonList = [];

  @override
  void initState() {
    super.initState();

    jsonList = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('New chat'),
          backgroundColor: Colors.green,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              print('Thoat');
            },
          ),
        ),
        body: ListView.builder(
          itemCount: jsonList.length,
          itemBuilder: (context, index) {
            var item = jsonList[index];

            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(800),
                child: Image.network(
                  item['avatar'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(item['name']),
              subtitle: Text('ID: ${item['id']}'),
              trailing: Icon(
                Icons.message,
                color: item['isRead']
                    ? Colors.green
                    : const Color.fromARGB(255, 119, 119, 119),
              ),
              onTap: () {
                setState(() {
                  // Cập nhật lại giá trị isRead và làm mới danh sách
                  item['isRead'] = !item['isRead'];
                });
              },
            );
          },
        ),
      ),
    );
  }
}
