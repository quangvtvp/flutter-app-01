import 'package:flutter/material.dart';

class FeedDetailScreen extends StatelessWidget {
  final FeedItemData feedItem;
  final VoidCallback onBack; // Callback to go back to the list

  const FeedDetailScreen({
    Key? key,
    required this.feedItem,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${feedItem.userName}\'s Post'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        // leading: IconButton(
        //   // Add a back button
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: onBack, // Call the back callback
        // ),
      ),
      body: Column(
        children: [
          // Display the original feed item (can reuse the FeedItem widget or build inline)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(feedItem.avatarUrl),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            feedItem.userName,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            feedItem.timeAgo,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    if (feedItem.mood != null)
                      Chip(
                        label: Text('Feeling: ${feedItem.mood}'),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                      ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Text(
                  feedItem.content,
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
                      label: Text('${feedItem.reactionCount} Reacts'),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        // Mock action
                      },
                      icon: const Icon(Icons.comment_outlined),
                      label: Text('${feedItem.commentCount} Comments'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1), // Separator

          Expanded(
            child: ListView.builder(
              itemCount: feedItem.comments.length,
              itemBuilder: (context, index) {
                return CommentItem(comment: feedItem.comments[index]);
              },
            ),
          ),
          const Divider(height: 1), // Separator
          // Comment Input Row
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      filled: true,
                      fillColor:
                          Color.fromARGB(255, 238, 238, 238), // Light grey fill
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Mock send action
                  },
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeedItemData {
  final String id; // Unique ID for the item
  final String userName;
  final String timeAgo;
  final String content;
  final String? mood;
  final bool shoutout;
  final int reactionCount;
  final int commentCount;
  final String avatarUrl;
  final List<CommentData> comments; // Add comments list

  const FeedItemData({
    required this.id,
    required this.userName,
    required this.timeAgo,
    required this.content,
    this.mood,
    this.shoutout = false,
    required this.reactionCount,
    required this.commentCount,
    required this.avatarUrl,
    required this.comments,
  });
}

class CommentData {
  final String id;
  final String userName;
  final String timeAgo;
  final String content;
  final String avatarUrl;

  const CommentData({
    required this.id,
    required this.userName,
    required this.timeAgo,
    required this.content,
    required this.avatarUrl,
  });
}

// --- Feed Item Widget (Tappable) ---
class FeedItem extends StatelessWidget {
  final FeedItemData item;
  final VoidCallback? onTap; // Add onTap callback

  const FeedItem({
    Key? key,
    required this.item,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        // Use InkWell for tap effect
        onTap: onTap, // Call the onTap callback
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(item.avatarUrl),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.userName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          item.timeAgo,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  if (item.mood != null)
                    Chip(
                      label: Text('Feeling: ${item.mood}'),
                      backgroundColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                    ),
                ],
              ),
              const SizedBox(height: 12.0),
              Text(
                item.content,
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
                    label: Text('${item.reactionCount} Reacts'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Mock action
                    },
                    icon: const Icon(Icons.comment_outlined),
                    label: Text('${item.commentCount} Comments'),
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

// --- Comment Item Widget ---
class CommentItem extends StatelessWidget {
  final CommentData comment;

  const CommentItem({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(comment.avatarUrl),
            radius: 16,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      comment.userName,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      comment.timeAgo,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  comment.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
