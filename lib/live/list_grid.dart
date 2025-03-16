import 'package:flutter/material.dart';
import 'package:flutter_application/exercise/stock.dart';

class MyListView extends StatelessWidget {
  const MyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1 / 1,
          ),
          itemBuilder: (context, index) {
            return MyStock();
          }),
    );
  }

  GridView _simpleGridview() {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      children: [
        ...List.generate(20, (index) {
          return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[100 * (index % 9)],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text('Item $index'),
            ),
          );
        })
      ],
    );
  }

  ListView _listviewBuilder() {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.black12,
          height: 2,
          thickness: 1,
        );
      },
      itemCount: 100,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Mục $index'),
          trailing: index == 9
              ? const Icon(Icons.more_time)
              : const Icon(Icons.more_horiz),
          leading: const Icon(Icons.wb_sunny),
          onTap: () {
            print('Tapped $index');
          },
        );
      },
    );
  }

  ListView _simpleListView() {
    return ListView(
      children: [
        ListTile(
          title: Text('Sun'),
          subtitle: Text('93 million miles away'),
          leading: Icon(Icons.wb_sunny),
        ),
        ListTile(
          title: Text('Earth'),
          subtitle: Text('93 million miles away'),
          leading: Icon(Icons.public),
        ),
        ListTile(
          title: Text('Moon'),
          subtitle: Text('93 million miles away'),
          leading: Icon(Icons.brightness_3),
        ),
        ListTile(
          title: Text('Moon'),
          subtitle: Text('93 million miles away'),
          leading: Icon(Icons.brightness_3),
          trailing: Icon(Icons.more_horiz),
        ),
        ListTile(
          title: Text('Moon'),
          subtitle: Text('93 million miles away'),
          leading: Icon(Icons.brightness_3),
        ),
        RadioListTile(
          value: 1,
          groupValue: 1,
          onChanged: null,
          title: Text('check list item'),
        ),
      ],
    );
  }
}
