import 'package:flutter/material.dart';

class CardDetail extends StatefulWidget {
  const CardDetail({super.key});

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  bool isShowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Detail'),
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
                  onPressed: () {
                    setState(() {
                      isShowing = !isShowing;
                    });
                  },
                  icon: isShowing
                      ? const Icon(Icons.arrow_drop_up)
                      : const Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          size: 50,
                        ),
                  splashRadius: 50,
                  iconSize: 50,
                ),
              ],
            ),
            Visibility(
              visible: isShowing,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: _buildTranslatedFlip(),
              ),
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
        color: const Color.fromRGBO(74, 14, 92, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Explain',
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
                    "ɪkˈspleɪn",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildTranslatedFlip() {
    return SizedBox(
      height: 300,
      child: Card(
        color: const Color.fromRGBO(74, 14, 92, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Explain',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'to make something clear or easy to understand by describing or giving information about it',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
