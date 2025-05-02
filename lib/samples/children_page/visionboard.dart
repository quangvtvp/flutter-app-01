// --- Vision Board Screen ---
import 'package:flutter/material.dart';

class VisionBoardScreen extends StatelessWidget {
  const VisionBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Vision Board'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: const [
          GoalItem(
            name: 'Family Vacation to Italy',
            progress: 0.7,
            owner: 'Mom & Dad',
            status: 'In Progress',
          ),
          GoalItem(
            name: 'Save for College Fund',
            progress: 0.5,
            owner: 'Dad',
            status: 'In Progress',
          ),
          GoalItem(
            name: 'Learn a New Family Recipe Every Month',
            progress: 1.0,
            owner: 'Mom & Big Sis',
            status: 'Completed',
          ),
          GoalItem(
            name: 'Renovate the Kitchen',
            progress: 0.2,
            owner: 'Dad',
            status: 'Planning',
          ),
          GoalItem(
            name: 'Read 10 Books This Year',
            progress: 0.8,
            owner: 'Big Sis',
            status: 'In Progress',
          ),
        ],
      ),
    );
  }
}

class GoalItem extends StatelessWidget {
  final String name;
  final double progress;
  final String owner;
  final String status;

  const GoalItem({
    Key? key,
    required this.name,
    required this.progress,
    required this.owner,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            LinearProgressIndicator(
              value: progress,
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Owner: $owner',
                    style: Theme.of(context).textTheme.bodySmall),
                Text('Status: $status',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
