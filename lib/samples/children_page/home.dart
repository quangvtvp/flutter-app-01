// --- Family Feed Screen ---
import 'package:flutter/material.dart';

class FamilyFeedScreen extends StatelessWidget {
  const FamilyFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Feed'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: const [
          FeedItem(
            userName: 'Mom',
            timeAgo: '5m ago',
            content:
                'Feeling grateful for this lovely evening with the family! ❤️',
            mood: 'Happy',
            reactionCount: 10,
            commentCount: 3,
            avatarUrl:
                'https://marketplace.canva.com/EAFltIh8PKg/1/0/1600w/canva-cute-anime-cartoon-illustration-girl-avatar-J7nVyTlhTAE.jpg', // Mock avatar
          ),
          FeedItem(
            userName: 'Dad',
            timeAgo: '1h ago',
            content:
                'Just finished building that treehouse! Kids are loving it. #FamilyFun',
            shoutout: true,
            reactionCount: 15,
            commentCount: 5,
            avatarUrl:
                'https://marketplace.canva.com/EAFltFTo1p0/1/0/400w/canva-FHrPI721fpQ.jpg', // Mock avatar
          ),
          FeedItem(
            userName: 'Big Sis',
            timeAgo: '3h ago',
            content:
                'Exams are finally over! Celebrating with pizza tonight! 🍕',
            mood: 'Relieved',
            reactionCount: 8,
            commentCount: 2,
            avatarUrl:
                'https://marketplace.canva.com/EAFmTOCdg-c/2/0/800w/canva-rh5j60LbXvI.jpg', // Mock avatar
          ),
          FeedItem(
            userName: 'Little Bro',
            timeAgo: 'Yesterday',
            content: 'Scored the winning goal in soccer practice! 🎉',
            shoutout: true,
            reactionCount: 12,
            commentCount: 4,
            avatarUrl:
                'https://marketplace.canva.com/EAFlcJIzmtg/1/0/800w/canva-U6MaG3J9sic.jpg', // Mock avatar
          ),
        ],
      ),
    );
  }
}

class FeedItem extends StatelessWidget {
  final String userName;
  final String timeAgo;
  final String content;
  final String? mood;
  final bool shoutout;
  final int reactionCount;
  final int commentCount;
  final String avatarUrl;

  const FeedItem({
    Key? key,
    required this.userName,
    required this.timeAgo,
    required this.content,
    this.mood,
    this.shoutout = false,
    required this.reactionCount,
    required this.commentCount,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/detail");
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(avatarUrl),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          timeAgo,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  if (mood != null)
                    Chip(
                      label: Text('Feeling: $mood'),
                      backgroundColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                    ),
                ],
              ),
              const SizedBox(height: 12.0),
              Text(
                content,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      // Mock action
                    },
                    icon: const Icon(Icons.thumb_up_alt_outlined),
                    label: Text('$reactionCount Reacts'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Mock action
                    },
                    icon: const Icon(Icons.comment_outlined),
                    label: Text('$commentCount Comments'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
