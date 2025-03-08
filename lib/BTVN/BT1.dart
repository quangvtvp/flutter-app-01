import 'package:flutter/material.dart';
import 'dart:math';

class BT_HS extends StatelessWidget {
  const BT_HS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    color: Colors.blue[100],
                    margin: const EdgeInsets.all(20),
                    width: 400,
                    height: 400,
                    child: const a()))));
  }
}

class a extends StatefulWidget {
  const a({super.key});

  @override
  State<a> createState() => BT_HS_State();
}

class BT_HS_State extends State<a> {
  List<List<dynamic>> Danh_sach_HS = [
    ['hs1', '1/2/1223'],
    ['hs2', '2/3/2314'],
    ['hs3', '1/6/2025'],
    ['hs4', '2/2/1892'],
    ['hs5', '7/6/2007'],
    ['hs6', '8/9/1000'],
    ['hs7', '8/9/2081'],
    ['hs8', '9/8/1945'],
    ['hs9', '30/4/1945'],
    ['hs10', '10/9/1999'],
  ];
  String name = "";
  String date = "";
  late int a; //khởi tạo a nhưng chưa gán giá trị, 1 lúc nào đó sẽ làm

  @override
  void initState() {
    super.initState();
    a = Danh_sach_HS.length + 1;
    //vì a và DS_HS cùng gọi 1 lúc nên ko thể gán giá trị của cái này theo cái kia dc, vậy nên ta sẽ gán khi chuẩn bị init
    ngau_nhien();
  }

  void ngau_nhien() {
    Random random = Random();
    int previous_a = a;
    while (a == previous_a) {
      a = random.nextInt(Danh_sach_HS.length);
    }
    ;
    List<dynamic> random_HS = Danh_sach_HS[a];

    setState(() {
      name = random_HS[0];
      date = random_HS[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.person,
          size: 100,
        ),
        Text('$name', style: TextStyle(fontSize: 65, color: Colors.red)),
        Text('$date', style: TextStyle(fontSize: 65, color: Colors.red)),
        IconButton(
            onPressed: () {
              ngau_nhien(); //khi bấm, sẽ chạy func ngau_nhien(), dẫn đến state mới
            },
            icon: Icon(Icons.shuffle, size: 50)),
      ],
    );
  }
}
