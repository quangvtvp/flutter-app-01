import 'package:flutter/material.dart';
import 'dart:math';

class widget_FlashCard extends StatelessWidget {
  const widget_FlashCard({super.key});
  @override
  Widget build(BuildContext context) {
    return const A();
  }
}

class A extends StatefulWidget {
  const A({super.key});

  @override
  State<A> createState() =>
      _widget_FlashCard_State(); // thêm '_' vào trước class state
}

class Vocabulary {
  String englishWord = '';
  String vietnameseMeaning = '';

  Vocabulary(this.englishWord, this.vietnameseMeaning);
}

List<Vocabulary> vocab_data = [
  Vocabulary("apple", "qua tao"),
  Vocabulary("banana", "qua chuoi"),
  Vocabulary("cat", "con meo"),
  Vocabulary("dog", "con cho"),
  Vocabulary("elephant", "con voi"),
  Vocabulary("flower", "bong hoa"),
  Vocabulary("guitar", "dan guitar"),
  Vocabulary("house", "ngoi nha"),
  Vocabulary("ice", "nuoc da"),
  Vocabulary("jungle", "rung"),
];
Vocabulary vocab = vocab_data[0];
String text = vocab_data[0].englishWord;
Random random = Random();
List<Widget> widget_data = []; // quản lí widget
int a = 0;

class _widget_FlashCard_State extends State<A> {
  @override
  void initState() {
    super.initState();
    _changeText;
    _changeVocab;
  }

  void _changeVocab() {
    int previous_a = a;
    while (a == previous_a) {
      a = random.nextInt(vocab_data.length);
    }
    ;
    vocab = vocab_data[a];
  }

  void _changeText() {
    text = (text == vocab.englishWord)
        ? vocab.vietnameseMeaning
        : vocab.englishWord;

    setState(() {
      text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(children: [
      Align(
          alignment: Alignment.topCenter,
          child: InkWell(
            onTap: _changeText,
            child: Container(
              color: Colors.blue[100],
              margin: const EdgeInsets.all(20),
              width: 300,
              height: 300,
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Căn giữa theo chiều dọc
                children: [
                  Icon(Icons.image, size: 100, color: Colors.black),
                  Text(
                    '$text',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 50),
                  ),
                ],
              ),
            ),
          )),
      Align(
          alignment: Alignment.bottomCenter,
          child: IconButton(
              onPressed: () {},
              icon: TextButton(
                onPressed: () {
                  _changeVocab();
                  _changeText();
                },
                child: Text(
                  'Change card',
                  style: TextStyle(fontSize: 50),
                ),
              ))),
    ])));
  }
}
