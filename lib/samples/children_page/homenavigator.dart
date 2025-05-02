import 'package:flutter/material.dart';
import 'package:flutter_application/samples/children_page/feeddetail.dart';
import 'package:flutter_application/samples/children_page/home.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({required this.navigatorKey, super.key});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator>
    with AutomaticKeepAliveClientMixin {
  // Placeholder for feed item
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    final feedItem = FeedItemData(
      id: 'f1',
      userName: 'Mom',
      timeAgo: '5m ago',
      content: 'Feeling grateful for this lovely evening with the family! ❤️',
      mood: 'Happy',
      reactionCount: 10,
      commentCount: 3,
      avatarUrl: 'https://via.placeholder.com/150/FF0000/FFFFFF?text=M',
      comments: [
        CommentData(
            id: 'c1',
            userName: 'Dad',
            timeAgo: '4m ago',
            content: 'Me too!',
            avatarUrl: 'https://via.placeholder.com/150/0000FF/FFFFFF?text=D'),
        CommentData(
            id: 'c2',
            userName: 'Big Sis',
            timeAgo: '3m ago',
            content: 'Aww, love you Mom!',
            avatarUrl: 'https://via.placeholder.com/150/00FF00/FFFFFF?text=S'),
        CommentData(
            id: 'c3',
            userName: 'Little Bro',
            timeAgo: '2m ago',
            content: 'Can we have ice cream?',
            avatarUrl: 'https://via.placeholder.com/150/FFFF00/000000?text=B'),
      ],
    );
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            // The initial screen for this tab.
            builder = (BuildContext _) => FamilyFeedScreen();
            break;
          case '/detail':
            // A child screen within this tab.
            builder = (BuildContext _) => FeedDetailScreen(
                  feedItem: feedItem,
                  onBack: () {},
                );
            break;
          default:
            // Handle unknown routes (optional).
            throw Exception('Invalid route: ${settings.name}');
        }
        // Return a MaterialPageRoute for smooth transitions.
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
