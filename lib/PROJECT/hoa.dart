import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://dbhwiwngltxrbuasrilt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRiaHdpd25nbHR4cmJ1YXNyaWx0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU3NTc2MzgsImV4cCI6MjA2MTMzMzYzOH0.OSwLzj3L2u4r9_WiFDFimLUdNw3RImF0jlkMCvgAUPw',
  );

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHoa(),
  ));
}

class MyHoa extends StatefulWidget {
  const MyHoa({super.key});

  @override
  State<MyHoa> createState() => _MyHoaState();
}

class _MyHoaState extends State<MyHoa> {
  final supabase = Supabase.instance.client;
  List<dynamic> topics = [];

  @override
  void initState() {
    super.initState();
    fetchTopics();
  }

  Future<void> fetchTopics() async {
    final response = await supabase.from('de_van').select();
    setState(() {
      topics = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Các Đề Văn'), backgroundColor: Colors.deepPurple),
      body: topics.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, index) {
                final topic = topics[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(topic['title'] ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Chủ đề: ${topic['topic']}"),
                        Text("Độ khó: ${topic['difficulty']}"),
                        Text("Thời gian: ${topic['time_limit']}"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                QuizPage(topicId: topic['id'].toString()),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class QuizPage extends StatelessWidget {
  final String? topicId;

  const QuizPage({super.key, this.topicId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Làm bài $topicId'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text('Nội dung đề bài với ID: $topicId'),
      ),
    );
  }
}
