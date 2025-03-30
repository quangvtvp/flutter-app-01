import 'package:flutter/material.dart';
import 'package:flutter_application/screens/leaderboard.dart';
import 'package:flutter_application/screens/single_choice.dart';
import 'package:flutter_application/screens/welcome.dart';

void main() {
  // runApp(const MyApp());
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home(context),
    );
  }

  Scaffold home(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePageWidget(),
                  ));
            },
            child: const Text('Open MyHomePage'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LeaderboardScreen()),
              );
            },
            child: const Text('Open Leaderboard'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Placeholder()),
              );
            },
            child: const Text('Open Welcome'),
          ),
        ],
      ),
    );
  }
}

class MyHomePageWidget extends StatelessWidget {
  const MyHomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Container(
        color: Colors.blue,
        child: const Center(
          child: Text(
            'Hello World',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      print('dong 1');
      print('dong 2');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    print('build _MyHomePageState');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
