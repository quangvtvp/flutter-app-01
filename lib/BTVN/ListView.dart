import 'package:flutter/material.dart';

double pt_B2(int x) {
  return (-(x * x - 10 * x) + 100).toDouble();
}

List<Widget> a = List.generate(
    11,
    (index) => Row(children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              color: Colors.red,
              width: pt_B2(index),
              height: pt_B2(index),
              child: Text(
                '$index',
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
          // const SizedBox(
          //   width: 10,
          // ),
        ]));

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Center(
            child: Scaffold(
      backgroundColor: Colors.black, //hey look what i found !
      body: PageView(
        //ListView và row khá giống nhau, nhưng ListView ko bị tràn màn hình
        //PageView tạo hiệu ứng trượt, gần giống. PageView mặc định là row => scrollDirection: Axis.horizontal NO NEED
        physics: BouncingScrollPhysics(), //căn bọn widget con vào đúng vị trí
        //scrollDirection: Axis.horizontal,
        children: [for (int i = 0; i < 11; i++) a[i]],
      ),
    )));
  }
}
