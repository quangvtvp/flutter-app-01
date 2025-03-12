import 'package:flutter/material.dart';

double pt_B2(int x) {
  return (-7 * (x * x - 10 * x) + 100).toDouble();
}

List<Widget> a = List.generate(
  11,
  (index) => Align(
    alignment: Alignment.center,
    child: Container(
      alignment: Alignment.center,
      color: Colors.red,
      width: pt_B2(index),
      height: pt_B2(index),
      child: Text(
        '$index',
        style: TextStyle(fontSize: 30 * (pt_B2(index) / 100)),
      ),
    ),
  ),
  //SizedBox(width: 200 * (pt_B2(index) / 100)),
);

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Center(
            child: Scaffold(
      backgroundColor: Colors.black, //hey look what i found !
      body: PageView(
        controller: PageController(
            viewportFraction: 0.5), //(mỗi widget con chỉ chiểm 0.1/1 màn hình)
        children: [for (int i = 0; i < 11; i++) a[i]],
      ),
    )));
  }
}
//ListView và row khá giống nhau, nhưng ListView ko bị tràn màn hình
//PageView tạo hiệu ứng trượt, gần giống. PageView mặc định là row => scrollDirection: Axis.horizontal NO NEED
