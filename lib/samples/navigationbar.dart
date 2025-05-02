import 'package:flutter/material.dart';
import 'package:flutter_application/samples/children_page/homenavigator.dart';
import 'package:flutter_application/samples/children_page/message.dart';
import 'package:flutter_application/samples/children_page/prompt_history.dart';
import 'package:flutter_application/samples/children_page/visionboard.dart';

import 'children_page/home.dart';
import 'children_page/notification.dart';

void main(List<String> args) {
  runApp(const MaterialApp(
    home: NavigationbarSample(),
  ));
}

class NavigationbarSample extends StatefulWidget {
  const NavigationbarSample({super.key});

  @override
  State<NavigationbarSample> createState() => _NavigationbarSampleState();
}

class _NavigationbarSampleState extends State<NavigationbarSample> {
  int currentPageIndex = 0;
  final homeNavigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'Prompt History',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        selectedIndex: currentPageIndex,
        indicatorColor: Colors.amber[800],
        onDestinationSelected: (index) {
          // Handle navigation
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: <Widget>[
          HomeNavigator(
            navigatorKey: homeNavigatorKey,
          ),
          MessagesScreen(),
          VisionBoardScreen(),
          HistoryPromptScreen(),
          NotificationScreen(),
        ],
      ),
    );
  }
}
