import 'package:flutter/material.dart';
import 'package:flutter_application/exercise/cards.dart';

class MyListview extends StatelessWidget {
  const MyListview({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: const [
            ListTile(title: Text('Mục 1')),
            ListTile(title: Text('Mục 2')),
            ListTile(title: Text('Mục 3')),
          ],
        ),
      ),
    );
  }
}

class MyListviewBuilder extends StatelessWidget {
  const MyListviewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(title: Text('Mục $index'));
          },
        ),
      ),
    );
  }
}

class MyGridviewCount extends StatelessWidget {
  const MyGridviewCount({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.count(
          crossAxisCount: 3, // 3 cột
          children: List.generate(9, (index) {
            // Tạo 9 mục
            return Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text('Mục ${index + 1}',
                      style: const TextStyle(color: Colors.white))),
            );
          }),
        ),
      ),
    );
  }
}

class MyGridviewBuilder extends StatelessWidget {
  const MyGridviewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home page'),
        ),
        body: GridView.builder(
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 cột
            childAspectRatio: 1,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CardDetail(),
                  ),
                );
              },
              child: Card(
                elevation: 4.0,
                child: Container(
                  color: Colors.green,
                  margin: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Mục ${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
