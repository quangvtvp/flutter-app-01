import 'package:flutter/material.dart';

class Vocabulary {
  String englishWord = '';
  String vietnameseMeaning = '';

  Vocabulary(this.englishWord, this.vietnameseMeaning);
}

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(backgroundColor: Colors.black, body: MyListView()));
  }
}
// màu nền mặc định của card là trắng, sẽ đè lên mọi câu lệnh

class MyListView extends StatefulWidget {
  const MyListView({super.key});

  @override
  State<MyListView> createState() => _ListViewState();
}

class _ListViewState extends State<MyListView> {
  List<Vocabulary> vocab_data = [
    Vocabulary("apple", "qua tao"),
    Vocabulary("banana", "qua chuoi"),
    Vocabulary("cat", "con meo"),
    Vocabulary("dog", "con cho"),
    Vocabulary("elephant", "con voi"),
    Vocabulary("flower", "bong hoa"),
    Vocabulary("guitar", "dan guitar"),
    Vocabulary("house", "ngoi nha"),
    Vocabulary("ice", "nuoc da"),
    Vocabulary("jungle", "rung"),
  ];
  final PageController _pageController =
      PageController(viewportFraction: 0.4); // i dunno, what it this job ?
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: _pageController, //kiểm soát widget dc hiển thị
        itemCount: 10, // số lượng widget con

        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          double scale = (_currentPage == index)
              ? 1.0
              : 0.5; //ko phải widget đang chiếu => thu nhỏ lại 1 nửa
          return Transform.scale(
              scale: scale,
              child: Align(
                  alignment: Alignment.topCenter,
                  child: CoupleCard(index, _currentPage, vocab_data)));
        });
  }
}

Widget CoupleCard(int index, int _currentPage, List vocab_data) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: _currentPage == index ? 300 : 0100,
        height: _currentPage == index ? 300 : 100,
        decoration: BoxDecoration(
          color: _currentPage == index ? Colors.blue : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Align(
          child: Text(
            '${vocab_data[index].englishWord}',
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
      AnimatedContainer(
        //container nhưng có hiệu ứng xuất hiện
        duration: Duration(milliseconds: 400), //thời gian chạy hiệu ứng
        width: _currentPage == index ? 300 : 100,
        height: _currentPage == index ? 300 : 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _currentPage == index ? Colors.blue : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: AnimatedDefaultTextStyle(
          //Text cũng animation luôn cho đồng bộ với container
          //Update: it's not work as i thought
          duration: const Duration(milliseconds: 400),
          style: TextStyle(
            fontSize: _currentPage == index ? 50 : 40,
            color: Colors.white,
          ),
          child: Text(
            '${vocab_data[index].vietnameseMeaning}',
          ),
        ),
      ),
    ],
  );
}
// nếu muốn chỉnh cả 2 thuộc tính color và borderRadius trong container, phải bọc trong Decoration
