import 'package:flutter/material.dart';

/// Flutter code sample for [NavigationDrawer].

void main() => runApp(const NavigationDrawerApp());

class NavigationDrawerApp extends StatelessWidget {
  const NavigationDrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const NavigationDrawerExample(),
    );
  }
}

class NavigationDrawerExample extends StatefulWidget {
  const NavigationDrawerExample({super.key});

  @override
  State<NavigationDrawerExample> createState() =>
      _NavigationDrawerExampleState();
}

class _NavigationDrawerExampleState extends State<NavigationDrawerExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
      scaffoldKey.currentState!.closeEndDrawer();
    });
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Navigation Drawer Example'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(child: Text('Page Index = $screenIndex')),
      ),
      endDrawer: NavigationDrawer(
        onDestinationSelected: handleScreenChanged,
        selectedIndex: screenIndex,
        children: const <Widget>[
          NavigationDrawerDestination(
            icon: Icon(Icons.widgets_outlined),
            label: Text('Messages'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.format_paint_outlined),
            label: Text('Profile'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.settings_outlined),
            label: Text('Settings'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
