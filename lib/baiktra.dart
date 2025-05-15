import 'package:flutter/material.dart';

void main() {
  runApp(const VocabularyApp());
}

class VocabularyApp extends StatelessWidget {
  const VocabularyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luyện Tập Từ Vựng',
      theme: ThemeData(
        primaryColor: const Color(0xFF4361EE),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF4361EE),
          secondary: const Color(0xFF3A0CA3),
        ),
        fontFamily: 'Inter',
      ),
      home: const VocabularyScreen(),
    );
  }
}

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  int _currentIndex = 0;
  int? _selectedAnswer;

  final List<Map<String, dynamic>> _questions = [
    {
      'word': 'Sunset',
      'pronunciation': '/ˈsʌn.set/',
      'options': ['Bình minh', 'Hoàng hôn', 'Trưa nắng', 'Đêm tối'],
      'correctIndex': 1,
    }
  ];

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];
    final isLastQuestion = _currentIndex == _questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LUYỆN TẬP',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'NỘP BÀI',
              style: TextStyle(
                color: Color(0xFF4361EE),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 24),

            // Question Card
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: Colors.grey[200]!,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      question['word'],
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3A0CA3),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      question['pronunciation'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Options
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: question['options'].length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return Material(
                    borderRadius: BorderRadius.circular(12),
                    color: _selectedAnswer == index
                        ? const Color(0xFF4361EE).withOpacity(0.1)
                        : Colors.grey[50],
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => setState(() => _selectedAnswer = index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _selectedAnswer == index
                                      ? const Color(0xFF4361EE)
                                      : Colors.grey[400]!,
                                  width: 2,
                                ),
                              ),
                              child: _selectedAnswer == index
                                  ? const Icon(
                                      Icons.circle,
                                      size: 12,
                                      color: Color(0xFF4361EE),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              question['options'][index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: _selectedAnswer == index
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Navigation
            Padding(
              padding: const EdgeInsets.only(bottom: 24, top: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _currentIndex == 0
                          ? null
                          : () => setState(() => _currentIndex--),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Color(0xFF4361EE)),
                      ),
                      child: const Text('CÂU TRƯỚC'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isLastQuestion
                          ? null
                          : () => setState(() => _currentIndex++),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4361EE),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'CÂU TIẾP',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
