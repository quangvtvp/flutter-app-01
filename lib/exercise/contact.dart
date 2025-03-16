import 'package:flutter/material.dart';

class ContactApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List Demo',
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Contact List Demo'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'ListView'),
                Tab(text: 'GridView'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ContactListView(),
              ContactGridViewBuilder(), // Changed to ContactGridViewBuilder
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy Contact Data (same as before)
class Contact {
  final String name;
  final String position;
  final String phoneNumber;

  Contact(
      {required this.name, required this.position, required this.phoneNumber});
}

List<Contact> dummyContacts = List.generate(
    20,
    (index) => Contact(
          name: 'Name ${index + 1}',
          position: 'Position ${index + 1}',
          phoneNumber: 'Phone number ${index + 1}',
        ));

// ListView Implementation (same as before)
class ContactListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyContacts.length,
      itemBuilder: (context, index) {
        final contact = dummyContacts[index];
        return ListTile(
          leading: Icon(Icons.account_circle, size: 40),
          title: Text('${contact.name} {${contact.position}}'),
          subtitle: Text('${contact.phoneNumber} {${contact.position}}'),
        );
      },
    );
  }
}

// GridView.builder Implementation (Refactored)
class ContactGridViewBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: dummyContacts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columns in the grid
        crossAxisSpacing: 16.0, // Added spacing between columns (optional)
        mainAxisSpacing: 16.0, // Added spacing between rows (optional)
        childAspectRatio: 0.8, // Optional: Adjust card aspect ratio
      ),
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        final contact = dummyContacts[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.account_circle, size: 60),
                SizedBox(height: 8),
                Text(
                  '${contact.name} {${contact.position}}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  '${contact.phoneNumber} {${contact.position}}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
