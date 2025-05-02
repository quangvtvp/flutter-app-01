// --- Messages Screen ---
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView(
        children: const [
          MessageTile(
            name: 'Family Chat',
            lastMessage: 'What\'s for dinner?',
            timeAgo: 'Now',
            isGroup: true,
          ),
          MessageTile(
            name: 'Mom',
            lastMessage: 'Don\'t forget your appointment!',
            timeAgo: '10m ago',
          ),
          MessageTile(
            name: 'Dad',
            lastMessage: 'Did you fix the car?',
            timeAgo: '1h ago',
          ),
          MessageTile(
            name: 'Big Sis',
            lastMessage: 'Can you help me with this?',
            timeAgo: 'Yesterday',
          ),
          MessageTile(
            name: 'Cousins Group',
            lastMessage: 'Party at my place next week!',
            timeAgo: '2 days ago',
            isGroup: true,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Mock action to create new conversation
        },
        tooltip: 'New Conversation',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String timeAgo;
  final bool isGroup;

  const MessageTile({
    Key? key,
    required this.name,
    required this.lastMessage,
    required this.timeAgo,
    this.isGroup = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        // Mock avatars or group icons
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        child: isGroup ? const Icon(Icons.group) : Text(name[0]),
      ),
      title: Text(name),
      subtitle: Text(
        lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(timeAgo),
      onTap: () {
        // Mock action to open conversation
      },
    );
  }
}
