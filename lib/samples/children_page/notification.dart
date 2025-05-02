import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView(
        children: const [
          NotificationItem(
            icon: Icons.question_answer, // New icon for daily prompt
            message: 'Your daily prompt is ready! Tap to see it.',
            timeAgo: 'Now',
          ),
          NotificationItem(
            icon: Icons.thumb_up,
            message: 'Dad reacted to your mood check-in.',
            timeAgo: '2m ago',
          ),
          NotificationItem(
            icon: Icons.message,
            message: 'New message from Mom.',
            timeAgo: '5m ago',
          ),
          NotificationItem(
            icon: Icons.star,
            message: 'Big Sis achieved the "Read 10 Books" goal!',
            timeAgo: '1h ago',
          ),
          NotificationItem(
            icon: Icons.thumb_up,
            message: 'Big Sis reacted to your shoutout.',
            timeAgo: '3h ago',
          ),
          NotificationItem(
            icon: Icons.message,
            message: 'New message in Family Chat.',
            timeAgo: 'Yesterday',
          ),
          NotificationItem(
            icon: Icons.star,
            message: 'Dad updated the "Family Vacation" goal.',
            timeAgo: 'Yesterday',
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final String message;
  final String timeAgo;

  const NotificationItem({
    Key? key,
    required this.icon,
    required this.message,
    required this.timeAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child:
            Icon(icon, color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
      title: Text(message),
      trailing: Text(timeAgo, style: Theme.of(context).textTheme.bodySmall),
      onTap: () {
        // Mock action for notification tap
      },
    );
  }
}
