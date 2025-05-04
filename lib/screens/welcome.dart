import 'package:flutter/material.dart';
import 'package:flutter_application/screens/home.dart';
import 'package:flutter_application/screens/leaderboard.dart';
import 'package:flutter_application/screens/message.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomeScreen(),
  ));
}

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _selectedIdex = 0;
  // global key for the scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _children = [
    const HomeWidget(),
    const MessageWidget(),
    const LeaderBoardWidget(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Main Screen'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.line_axis_sharp),
            label: 'Vision board',
          ),
        ],
        selectedIndex: _selectedIdex,
        indicatorColor: Colors.amber[800],
        onDestinationSelected: (index) {
          // Handle navigation
          setState(() {
            // Update the selected index
            _selectedIdex = index;
          });
        },
      ),
      body: _children[_selectedIdex],
      endDrawer: NavigationDrawer(
        selectedIndex: _selectedIdex,
        onDestinationSelected: (index) {
          // Handle navigation
          setState(() {
            // Update the selected index
            _selectedIdex = index;
            // close the drawer
            // Scaffold.of(context).closeEndDrawer();
            _scaffoldKey.currentState?.closeEndDrawer();
          });
        },
        children: const [
          NavigationDrawerDestination(
            icon: Icon(Icons.call),
            label: Text('audio call'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.message),
            label: Text('Messages'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.line_axis_sharp),
            label: Text('Vision board'),
          ),
        ],
      ),
    );
  }
}
