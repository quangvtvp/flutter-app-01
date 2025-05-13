import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề
              const Text(
                "Messages",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Danh sách tin nhắn
              Expanded(
                child: ListView.separated(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return _buildMessageItem(context, message);
                  },
                  separatorBuilder: (_, __) => const Divider(height: 1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget cho từng item tin nhắn
  Widget _buildMessageItem(BuildContext context, Message message) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[200],
        child: Icon(Icons.person, color: Colors.blue[800]),
      ),
      title: Text(message.sender,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle:
          Text(message.preview, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(message.time, style: const TextStyle(fontSize: 12)),
          if (message.unread)
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
      onTap: () {
        // Điều hướng sang màn hình chi tiết tin nhắn nếu cần
        _showMessageDetail(context, message);
      },
    );
  }

  void _showMessageDetail(BuildContext context, Message message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message.sender),
        content: Text(message.fullMessage),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text("OK"),
          )
        ],
      ),
    );
  }
}

// Dữ liệu giả lập
final List<Message> messages = [
  Message(
    sender: "Sarah",
    preview: "Hey, how are you doing today?",
    fullMessage: "Hi there! I hope you're having a great day.",
    time: "10:30 AM",
    unread: true,
  ),
  Message(
    sender: "John",
    preview: "Check out this cool new feature!",
    fullMessage: "You should definitely try the new prompt generator.",
    time: "Yesterday",
    unread: false,
  ),
  Message(
    sender: "Support",
    preview: "Your account has been updated.",
    fullMessage: "Your subscription plan has been successfully upgraded.",
    time: "2 days ago",
    unread: false,
  ),
];

class Message {
  final String sender;
  final String preview;
  final String fullMessage;
  final String time;
  final bool unread;

  Message({
    required this.sender,
    required this.preview,
    required this.fullMessage,
    required this.time,
    this.unread = false,
  });
}
