import 'package:flutter/material.dart';

class RowAndColumn extends StatelessWidget {
  const RowAndColumn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Row and Column'),
      ),
      body: Column(
        children: [
          _buildRow1(),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
          _buildRow2(),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
          _buildRow3(),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
          _buildRow4(),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
          _buildRow5(),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
          _buildRow6(),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
          _buildRow7(),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Row _buildRow7() {
return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: 100
          ,
        ),
        Container(
          color: Colors.red,
          width:50,
          height:50,
        ),
        Container(
          color: Colors.green,
          width:50,
          height:50,
        ),
      ],
    );
  }
  Row _buildRow6() {
return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
      children: [
        
        
        Container(
          color: Colors.red,
          width:50,
          height:50,
        ),
        Container(
          color: Colors.green,
          width:50,
          height:50,
        ),
      ],
    );
  }
  Row _buildRow5() {
return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      
      children: [
        Container(
          color: Colors.red,
          width:50,
          height:50,
        ),
        Container(
          color: Colors.green,
          width:50,
          height:50,
        ),
      ],
    );
  }
  Row _buildRow4() {
return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      
      children: [
       
        Container(
          color: Colors.green,
          width:50,
          height:50,
        ),
      ],
    );
  }
  Row _buildRow3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
     
      children: [
       
        Expanded(
          flex: 9,
          child: Container(
            color: Colors.red,
            width:50,
            height:50,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.green,
            width:50,
            height:50,
          ),
        ),
      ],
    );
  }

  Row _buildRow2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            color: Colors.red,
            width:50,
            height:50,
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.green,
            width:50,
            height:50,
          ),
        ),
        
      ],
    );
  }

  Row _buildRow1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      Container(
        color: Colors.red,
        width:50,
        height:50,
      ),
        Container(
          color: Colors.green,
          width:50,
          height:50,
        ),
      ],
    );
  }
}
