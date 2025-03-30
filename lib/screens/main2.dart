import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text('Học sinh $index'),
                  subtitle: Text('Điểm số của học sinh $index'),
                  leading: Text("$index"),
                  trailing: Icon(Icons.arrow_forward),
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}
