import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyJsonParse extends StatelessWidget {
  const MyJsonParse({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Json Parse'),
      ),
      body: Center(
          child: FutureBuilder<String>(
        future: loadJson(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      )),
    ));
  }

  Future<String> loadJson() async {
    String a = await rootBundle.loadString('assets/data.json');
    a = await jsonDecode(a);
    return a;
  }
}
