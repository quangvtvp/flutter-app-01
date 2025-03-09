import 'package:flutter/material.dart';

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

Vocabulary Test = Vocabulary('Test', 'kiem tra');

class _widget_FlashCard_State extends State<A> {
  @override
  void initState() {
    super.initState();
    _changeText;
  }

  String text = Test.englishWord;
  void _changeText() {
    text =
        (text == Test.englishWord) ? Test.vietnameseMeaning : Test.englishWord;

    setState(() {
      text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(children: [
      InkWell(
          onTap: _changeText,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: Colors.blue[100],
              margin: const EdgeInsets.all(20),
              width: 300,
              height: 300,
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Căn giữa theo chiều dọc
                children: [
                  Icon(Icons.image, size: 100, color: Colors.black), // Icon
                  Text(
                    '$text',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 80),
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
                onPressed: () {},
                child: Text(
                  'Change card',
                  style: TextStyle(fontSize: 50),
                ),
              ))),
    ])));
  }
}
