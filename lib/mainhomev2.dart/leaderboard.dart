import 'package:flutter/material.dart';

class LeaderBoardWidget extends StatelessWidget {
  const LeaderBoardWidget({super.key});

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
                "Vision Board",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Danh sách mục tiêu
              Expanded(
                child: ListView.separated(
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    final goal = goals[index];
                    return _buildGoalItem(context, goal);
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

  // Widget cho từng mục tiêu
  Widget _buildGoalItem(BuildContext context, Goal goal) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green[200],
        child: Icon(Icons.check_circle_outline, color: Colors.green[800]),
      ),
      title:
          Text(goal.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle:
          Text(goal.description, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(goal.progress.toString() + "%",
              style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: goal.progress / 100,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        // Điều hướng sang màn hình chi tiết mục tiêu nếu cần
        _showGoalDetail(context, goal);
      },
    );
  }

  void _showGoalDetail(BuildContext context, Goal goal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(goal.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(goal.description),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: goal.progress / 100,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            const SizedBox(height: 8),
            Text("${goal.progress}% completed"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text("Close"),
          )
        ],
      ),
    );
  }
}

// Dữ liệu giả lập
final List<Goal> goals = [
  Goal(
    title: "Complete Daily Journal",
    description: "Write a daily journal entry every day.",
    progress: 75,
  ),
  Goal(
    title: "Learn 10 New Words",
    description: "Expand your vocabulary by learning 10 new words each week.",
    progress: 50,
  ),
  Goal(
    title: "Finish Reading a Book",
    description: "Read at least one book this month.",
    progress: 25,
  ),
];

class Goal {
  final String title;
  final String description;
  final int progress;

  Goal({
    required this.title,
    required this.description,
    required this.progress,
  });
}
