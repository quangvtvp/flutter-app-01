import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return buildSingleChildColumn();
  }

  SingleChildScrollView buildSingleChildColumn() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildRowColumnContainerStackExpandedFlexible(),
          SizedBox(height: 20),
          _buildListViewGridView(),
          SizedBox(height: 20),
          _buildSingleChildScrollViewCenterAlignPaddingSizedBoxImage(),
        ],
      ),
    );
  }

  // Group 1: Row, Column, Container, Stack, Expanded, Flexible
  Widget _buildRowColumnContainerStackExpandedFlexible() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Row, Column, Container, Stack, Expanded, Flexible",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 100,
                  color: Colors.blue,
                  child: Center(child: Text("Expanded 2")),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  height: 100,
                  color: Colors.green,
                  child: Center(child: Text("Flexible 1")),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  color: Colors.red,
                  child: Center(child: Text("Expanded 1")),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Stack(
            children: [
              Container(
                height: 150,
                width: 300,
                color: Colors.yellow[100],
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.orange,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Text("Stacked Text"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Group 2: ListView & GridView
  Widget _buildListViewGridView() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ListView & GridView",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.purple[100 * (index + 1)],
                  child: Center(child: Text("List $index")),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.teal[100 * (index + 1)],
                  child: Center(child: Text("Grid $index")),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Group 3: SingleChildScrollView, Center, Align, Padding, SizedBox, Image
  Widget _buildSingleChildScrollViewCenterAlignPaddingSizedBoxImage() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[400],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("SingleChildScrollView, Center, Align, Padding, SizedBox, Image",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    height: 100,
                    child: Image.network(
                      'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    height: 100,
                    child: Image.network(
                      'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    height: 100,
                    child: Image.network(
                      'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    height: 100,
                    child: Image.network(
                      'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    height: 100,
                    child: Image.network(
                      'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Container(
              width: 100,
              height: 50,
              color: Colors.pink,
              child: Center(child: Text("Centered")),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 80,
              height: 40,
              color: Colors.brown,
              child: Center(child: Text("Aligned")),
            ),
          ),
        ],
      ),
    );
  }
}
