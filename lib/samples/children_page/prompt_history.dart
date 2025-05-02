import 'package:flutter/material.dart';

class HistoryPromptScreen extends StatelessWidget {
  const HistoryPromptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prompt History'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: const [
          PromptHistoryItem(
            date: 'April 30, 2025',
            type: 'Gratitude-focused',
            prompt:
                'What is one small thing that happened today that you are grateful for?',
          ),
          PromptHistoryItem(
            date: 'April 29, 2025',
            type: 'Lighthearted',
            prompt:
                'If our family was a type of food, what would we be and why?',
          ),
          PromptHistoryItem(
            date: 'April 28, 2025',
            type: 'Story-based',
            prompt: 'Tell a short story about a memorable family adventure.',
          ),
          PromptHistoryItem(
            date: 'April 27, 2025',
            type: 'Serious',
            prompt: 'What is one value that is most important to our family?',
          ),
          PromptHistoryItem(
            date: 'April 26, 2025',
            type: 'Gratitude-focused',
            prompt:
                'Share something you appreciate about another family member today.',
          ),
        ],
      ),
    );
  }
}

class PromptHistoryItem extends StatelessWidget {
  final String date;
  final String type;
  final String prompt;

  const PromptHistoryItem({
    Key? key,
    required this.date,
    required this.type,
    required this.prompt,
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
              date,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'Type: $type',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8.0),
            Text(
              prompt,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
