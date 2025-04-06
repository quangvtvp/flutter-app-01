import 'dart:convert';
import 'package:flutter/material.dart';

class MyJsonPage extends StatelessWidget {
  final String jsonString = '''[
    {
      "id": 1,
      "name": "Bánh mì Sourdough",
      "link": "https://your-image-link.com/bread1.jpg",
      "isRead": true
    },
    {
      "id": 2,
      "name": "Bánh mì nguyên cám",
      "link": "https://your-image-link.com/bread2.jpg",
      "isRead": false
    }
  ]'''; // Giả sử bạn đã có jsonString

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> jsonList = List<Map<String, dynamic>>.from(jsonDecode(jsonString));

    return Scaffold(
      appBar: AppBar(title: Text('Danh sách Bánh Mì')),
      body: ListView.builder(
        itemCount: jsonList.length,
        itemBuilder: (context, index) {
          var item = jsonList[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item['link'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(item['name']),
            subtitle: Text('ID: ${item['id']}'),
            trailing: Icon(
              item['isRead'] ? Icons.check_circle : Icons.radio_button_unchecked,
              color: item['isRead'] ? Colors.green : Colors.red,
            ),
          );
        },
      ),
    );
  }
}
