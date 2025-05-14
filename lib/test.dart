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
          seedColor: Colors.blue,
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
      VocabularyItem(
        id: '3',
        word: 'Ubiquitous',
        pronunciation: '/juːˈbɪk.wɪ.təs/',
        meaning: 'Có mặt ở khắp mọi nơi',
        options: ['Hiếm có', 'Có mặt khắp nơi', 'Đặc biệt', 'Bí ẩn'],
        correctIndex: 1,
      ),
      VocabularyItem(
        id: '4',
        word: 'Ephemeral',
        pronunciation: '/ɪˈfem.ɚ.əl/',
        meaning: 'Ngắn ngủi, thoáng qua',
        options: ['Vĩnh cửu', 'Ngắn ngủi', 'Thường xuyên', 'Liên tục'],
        correctIndex: 1,
      ),
    ];
  }

  void _submitAnswer() {
    bool hasUnanswered = _userAnswers.any((answer) => answer == null);
    if (hasUnanswered) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Xác nhận nộp bài'),
          content: const Text(
              'Bạn vẫn còn câu hỏi chưa trả lời. Bạn có chắc chắn muốn nộp bài?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _isSubmitted = true;
                });
              },
              child: const Text('Nộp bài'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Xác nhận nộp bài'),
          content: const Text('Bạn có chắc chắn muốn nộp bài?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _isSubmitted = true;
                });
              },
              child: const Text('Nộp bài'),
            ),
          ],
        ),
      );
    }
  }

  void _nextQuestion() {
    setState(() {
      if (_currentIndex < _vocabularyItems.length - 1) {
        _currentIndex++;
      } else {
        _submitAnswer();
      }
    });
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = _vocabularyItems[_currentIndex];
    final answerIndex = _userAnswers[_currentIndex];

    if (_isSubmitted) {
      int correctCount = 0;
      for (int i = 0; i < _vocabularyItems.length; i++) {
        if (_userAnswers[i] != null &&
            _userAnswers[i] == _vocabularyItems[i].correctIndex) {
          correctCount++;
        }
      }

      return _buildResultsScreen(correctCount);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Câu ${_currentIndex + 1}/${_vocabularyItems.length}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ElevatedButton(
              onPressed: _submitAnswer,
              child: const Text('Nộp bài'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    const Color.fromARGB(255, 24, 106, 173), // Màu xanh dương
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    if (item.imageUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item.imageUrl!,
                          height: 150,
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
                              child: const Icon(Icons.broken_image),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      item.word,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 43, 146, 231),
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
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.8,
                children: List.generate(item.options.length, (index) {
                  bool isSelected = answerIndex == index;
                  String optionLabel = String.fromCharCode(65 + index);

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _userAnswers[_currentIndex] = index;
                        });
                      },
                      child: Card(
                        elevation: isSelected ? 3 : 2,
                        margin: const EdgeInsets.all(4),
                        color: isSelected ? Colors.blue.shade50 : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isSelected
                                ? Colors.blue
                                : Colors.grey.withOpacity(0.3),
                            width: isSelected ? 3 : 1.5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        isSelected ? Colors.blue : Colors.grey,
                                  ),
                                ),
                                child: Text(
                                  optionLabel,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item.options[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? Colors.blue[800]
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _currentIndex == 0 ? null : _previousQuestion,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: _currentIndex == 0
                          ? Colors.grey[300] // Màu xám nhạt khi disabled
                          : const Color.fromARGB(
                              255, 95, 173, 238), // Màu xám xanh khi enabled
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Câu trước'),
                  ),
                  ElevatedButton(
                    onPressed: _currentIndex == _vocabularyItems.length - 1
                        ? null
                        : _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: _currentIndex ==
                              _vocabularyItems.length - 1
                          ? Colors.grey[300] // Màu xám nhạt khi disabled
                          : const Color.fromARGB(255, 95, 173,
                              238), // Màu xanh dương khi enabled (giống nút Nộp bài)
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Câu tiếp'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsScreen(int correctCount) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kết quả kiểm tra')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bạn trả lời đúng $correctCount/${_vocabularyItems.length} câu!',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
