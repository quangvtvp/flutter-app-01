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
      title: 'Kiểm Tra Từ Vựng Tiếng Anh',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const VocabularyTestScreen(),
    );
  }
}

class VocabularyItem {
  final String id;
  final String word;
  final String pronunciation;
  final String meaning;
  final String? imageUrl;
  final List<String> options;
  final int correctIndex;

  VocabularyItem({
    required this.id,
    required this.word,
    required this.pronunciation,
    required this.meaning,
    this.imageUrl,
    required this.options,
    required this.correctIndex,
  });
}

class VocabularyTestScreen extends StatefulWidget {
  const VocabularyTestScreen({super.key});

  @override
  State<VocabularyTestScreen> createState() => _VocabularyTestScreenState();
}

class _VocabularyTestScreenState extends State<VocabularyTestScreen> {
  late List<VocabularyItem> _vocabularyItems;
  late List<int?> _userAnswers;
  int _currentIndex = 0;
  bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();
    _vocabularyItems = _getVocabularyItems();
    _userAnswers = List.filled(_vocabularyItems.length, null);
  }

  List<VocabularyItem> _getVocabularyItems() {
    return [
      VocabularyItem(
        id: '1',
        word: 'Sunset',
        pronunciation: '/ˈsʌn.set/',
        meaning: 'Hoàng hôn',
        imageUrl:
            'https://tse2.mm.bing.net/th?id=OIP.tCpnJySWyC94OXaWTw9NAgHaD4&pid=Api&P=0&h=180',
        options: ['Bình minh', 'Hoàng hôn', 'Trưa nắng', 'Đêm tối'],
        correctIndex: 1,
      ),
      VocabularyItem(
        id: '2',
        word: 'Diligent',
        pronunciation: '/ˈdɪl.ɪ.dʒənt/',
        meaning: 'Chăm chỉ, cần cù',
        imageUrl:
            'https://tse1.mm.bing.net/th?id=OIP.yv9vj0Ps35fvzMUZg85qZgHaE7&pid=Api&P=0&h=180',
        options: ['Lười biếng', 'Thông minh', 'Chăm chỉ', 'Nhanh nhẹn'],
        correctIndex: 2,
      ),
    ];
  }

  void _submitAnswer() {
    bool hasUnanswered = _userAnswers.any((answer) => answer == null);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Xác nhận nộp bài',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          hasUnanswered
              ? 'Bạn vẫn còn câu hỏi chưa trả lời. Bạn có chắc chắn muốn nộp bài?'
              : 'Bạn đã hoàn thành tất cả câu hỏi. Bạn có muốn nộp bài ngay bây giờ?',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _isSubmitted = true);
            },
            child: const Text(
              'Nộp bài',
              style: TextStyle(
                color: Color.fromARGB(255, 27, 94, 148),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  void _nextQuestion() {
    if (_currentIndex < _vocabularyItems.length - 1) {
      setState(() => _currentIndex++);
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isSubmitted) {
      int correctCount = _calculateCorrectAnswers();
      return _buildResultsScreen(correctCount);
    }

    final item = _vocabularyItems[_currentIndex];
    final isLastQuestion = _currentIndex == _vocabularyItems.length - 1;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 217, 242),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_currentIndex + 1}/${_vocabularyItems.length}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(228, 246, 244, 244),
              ),
            ),
            const Text(
              'Luyện tập',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 247, 245, 245),
              ),
            ),
            const SizedBox(width: 40), // Để cân bằng với bên trái
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 184, 58, 207),
        elevation: 4,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: _submitAnswer,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 198, 105, 232),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text(
                'Nộp bài',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.fromLTRB(16, 8, 16, 16), // Thêm padding bottom
        child: Column(
          children: [
            _buildQuestionCard(item),
            const SizedBox(height: 16),
            Expanded(child: _buildOptionsGrid(item)),
            const SizedBox(height: 16),
            _buildNavigationButtons(isLastQuestion),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(VocabularyItem item) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 340,
        width: 440,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (item.imageUrl != null) _buildQuestionImage(item),
            Text(
              item.word,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 48, 140, 216),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.pronunciation,
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionImage(VocabularyItem item) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            item.imageUrl!,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 150,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 150,
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image, size: 50),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildOptionsGrid(VocabularyItem item) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.4,
      children: List.generate(item.options.length, (index) {
        final isSelected = _userAnswers[_currentIndex] == index;
        final optionLabel = String.fromCharCode(65 + index);

        return GestureDetector(
          onTap: () => setState(() => _userAnswers[_currentIndex] = index),
          child: Card(
            elevation: isSelected ? 4 : 2,
            margin: const EdgeInsets.all(4),
            color: isSelected ? const Color(0xFFBBDEFB) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isSelected
                    ? const Color(0xFF2196F3)
                    : Colors.grey.withOpacity(0.3),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          isSelected ? const Color(0xFF2196F3) : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            isSelected ? const Color(0xFF2196F3) : Colors.grey,
                      ),
                    ),
                    child: Text(
                      optionLabel,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item.options[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color:
                            isSelected ? const Color(0xFF2196F3) : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNavigationButtons(bool isLastQuestion) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: _currentIndex == 0 ? null : _previousQuestion,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: _currentIndex == 0
                ? Colors.grey[300]
                : const Color.fromARGB(255, 63, 161, 241),
            foregroundColor: Colors.white,
          ),
          child: const Text('Câu trước', style: TextStyle(fontSize: 16)),
        ),
        ElevatedButton(
          onPressed: isLastQuestion ? null : _nextQuestion,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: isLastQuestion
                ? Colors.grey[300]
                : const Color.fromARGB(255, 63, 161, 241),
            foregroundColor: Colors.white,
          ),
          child: const Text('Câu tiếp', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  int _calculateCorrectAnswers() {
    int count = 0;
    for (int i = 0; i < _vocabularyItems.length; i++) {
      if (_userAnswers[i] == _vocabularyItems[i].correctIndex) {
        count++;
      }
    }
    return count;
  }

  Widget _buildResultsScreen(int correctCount) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết quả kiểm tra'),
        backgroundColor: const Color(0xFF2196F3),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bạn trả lời đúng $correctCount/${_vocabularyItems.length} câu!',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2196F3),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                      _userAnswers = List.filled(_vocabularyItems.length, null);
                      _isSubmitted = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFF2196F3),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Làm lại bài kiểm tra',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
