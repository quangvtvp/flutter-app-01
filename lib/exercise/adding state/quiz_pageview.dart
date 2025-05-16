import 'package:flutter/material.dart';
import 'package:flutter_application/exercise/adding%20state/quiz_with_data.dart';
import 'package:flutter_application/exercise/adding%20state/single_choice.dart';
import 'package:flutter_application/samples/supabase_functions/model/exam_detail.dart';

class MyQuizPageview extends StatefulWidget {
  final ExamDetail examDetail;
  const MyQuizPageview({super.key, required this.examDetail});

  @override
  State<MyQuizPageview> createState() => _MyQuizPageviewState();
}

class _MyQuizPageviewState extends State<MyQuizPageview>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.examDetail.questions.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pageController = PageController(
      initialPage: 0,
    );
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: PageView(
            controller: pageController,
            onPageChanged: (index) {
              _tabController.animateTo(index);
            },
            children: widget.examDetail.questions
                .map((question) => MySingleChoiceQuiz(question: question))
                .toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: const Text('Previous'),
            ),
            ElevatedButton(
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: const Text('Next'),
            ),
          ],
        )
      ],
    );
  }
}
