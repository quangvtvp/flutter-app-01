import 'package:flutter/material.dart';

class CardDetail extends StatefulWidget {
  const CardDetail({super.key});

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text('Card'),
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: _buildVocabFlip(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                constraints: const BoxConstraints(
                  minWidth: 50,
                  minHeight: 50,
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  size: 50,
                ),
                splashRadius: 50,
                iconSize: 50,
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: _buildTranslaterFlip(),
          ),
        ],
      ),
    ),
  );
}

SizedBox _buildVocabFlip() {
  return SizedBox(
    height: 300,
    child: Card(
      color: Colors.deepPurpleAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Hieu',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 8.0,
                  ),
                  child: Icon(
                    Icons.volume_up,
                    color: Colors.white,
                  ),
                  ),
                  Text(
                    "H",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
              ],
            )
          )
        ],
      ),
      ),
    );
}
}

SizedBox _buildTranslaterFlip() {
  return SizedBox(
    height: 300,
    child: Card(
      color: Colors.deepPurpleAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Hieu',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 8.0,
                  ),
                ),
              Text(
                'Nguyen Duc Hieu',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              ],
            ),
            ),
        ],
      ),
    ),
  );
}
