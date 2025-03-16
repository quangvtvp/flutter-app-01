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
      PageController(viewportFraction: 0.2); // i dunno, what it this job ?
  int _currentPage = 0;
  int itemcount = 10;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly //another useless line
        ,
        children: [
          Expanded(
              // Chúa biết tại sao phải bọc trong expanded
              // ko bọc thì đen thui ???
              flex: 30,
              child: PageView.builder(
                  controller: _pageController, //kiểm soát widget dc hiển thị
                  itemCount: itemcount, // số lượng widget con

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
                            child:
                                EnglishCard(index, _currentPage, vocab_data)));
                  })),
          Expanded(flex: 20, child: MeaningCard(_currentPage, vocab_data)),
          Expanded(
            flex: 1,
            child: PageProgress2(_currentPage, itemcount),
          )
        ]);
  }
}

Widget EnglishCard(int index, int _currentPage, List vocab_data) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      AnimatedContainer(
        //container nhưng có hiệu ứng xuất hiện
        duration: Duration(milliseconds: 200),
        //thời gian chạy hiệu ứng
        width: _currentPage == index ? 300 : 100,
        height: _currentPage == index ? 300 : 100,
        decoration: BoxDecoration(
          color: _currentPage == index ? Colors.blue : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Align(
          child: Text(
            '${vocab_data[index].englishWord}',
            style: TextStyle(fontSize: _currentPage == index ? 50 : 25),
          ),
        ),
      ),
    ],
  );
}
// nếu muốn chỉnh cả 2 thuộc tính color và borderRadius trong container, phải bọc trong Decoration

Widget MeaningCard(int _currentPage, List vocab_data) {
  return Container(
    width: 500,
    height: 40,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(10 * _currentPage.toDouble()),
    ),
    child: Text(
      '${vocab_data[_currentPage].vietnameseMeaning}',
      style: TextStyle(fontSize: 100),
    ),
  );
}

// Container PageProgress(int _currentPage, int itemcount) {
//   return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(100),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//               child: Container(
//             color: Colors.purple,
//             width: 100,
//           )),
//         ],
//       ));
// }

Container PageProgress(int _currentPage, int itemcount) {
  double progress = _currentPage / (itemcount - 1);

  return Container(
    decoration: BoxDecoration(
      //color: Colors.white,
      borderRadius: BorderRadius.circular(1000),
    ),
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: progress,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ],
    ),
  );
}
//i have no idea how doest it works, but it works !

Container PageProgress2(int _currentPage, int itemcount) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(100),
    ),
    child: progress(_currentPage, itemcount),
  );
}
// liệu có thể dùng pageview để tạo hiệu ứng chuyển tiếp không ?

Row progress(int _currentPage, int itemcount) {
  List<Widget> a = List.generate(
      itemcount,
      (index) => Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: (index == _currentPage) ? Colors.purple : Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ));
  return Row(children: [for (int i = 0; i < itemcount; i++) a[i]]);
}
