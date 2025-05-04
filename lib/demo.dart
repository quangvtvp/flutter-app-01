import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'NavigationRail Demo',
      home: NavigationRailExample(),
    );
  }
}

class NavigationRailExample extends StatefulWidget {
  const NavigationRailExample({Key? key}) : super(key: key);

  @override
  State<NavigationRailExample> createState() => _NavigationRailExampleState();
}

class _NavigationRailExampleState extends State<NavigationRailExample> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Dashboard', style: TextStyle(fontSize: 30))),
    Center(child: Text('Orders', style: TextStyle(fontSize: 30))),
    Center(child: Text('Customers', style: TextStyle(fontSize: 30))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row( // Dùng Row để đặt NavigationRail và nội dung cạnh nhau
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all, // Hiển thị cả icon và label
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.workspaces_outline),
                selectedIcon: Icon(Icons.workspaces),
                label: Text('Orders'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: Text('Customers'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1), // Đường phân cách
          Expanded( // Phần còn lại của màn hình hiển thị nội dung
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}