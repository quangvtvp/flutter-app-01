import 'package:flutter/material.dart';
import 'package:flutter_application/samples/children_page/homenavigator.dart';
import 'package:flutter_application/samples/children_page/message.dart';
import 'package:flutter_application/samples/children_page/prompt_history.dart';
import 'package:flutter_application/samples/children_page/visionboard.dart';

import 'children_page/home.dart';
import 'children_page/notification.dart';

void main(List<String> args) {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      drawer: NavigationDrawer(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (index) {
          // Handle navigation
          setState(() {
            currentPageIndex = index;
            scaffoldKey.currentState?.closeDrawer();
          });
        },
        children: const [
          NavigationDrawerDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.message),
            label: Text('Messages'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.line_axis_sharp),
            label: Text('Vision board'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.history),
            label: Text('Prompt History'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.notifications),
            label: Text('Notifications'),
          ),
        ],
      ),
      endDrawer: NavigationDrawer(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (index) {
          // Handle navigation
          setState(() {
            currentPageIndex = index;
            scaffoldKey.currentState?.closeEndDrawer();
          });
        },
        children: const [
          NavigationDrawerDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.message),
            label: Text('Messages'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.line_axis_sharp),
            label: Text('Vision board'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.history),
            label: Text('Prompt History'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.notifications),
            label: Text('Notifications'),
          ),
        ],
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
