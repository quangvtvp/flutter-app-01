import 'package:flutter/material.dart';
import 'package:flutter_application/model/vocabulary.dart';

class CardFlip extends StatefulWidget {
  const CardFlip({super.key, required this.vocab});
  final Vocabulary vocab;

  @override
  State<CardFlip> createState() => _CardFlipState();
}

class _CardFlipState extends State<CardFlip> {
  bool showExplaination = false;

  void _toggleShowExplaination() {
    setState(() {
      showExplaination = !showExplaination;
    });
  }

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
              child: _buildVocabFlip(widget.vocab),
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
                    _toggleShowExplaination();
                  },
                  icon: showExplaination
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
              visible: showExplaination,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: _buildTranslatedFlip(widget.vocab),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildVocabFlip(Vocabulary vocab) {
    return SizedBox(
      height: 300,
      child: Card(
        color: const Color.fromRGBO(74, 14, 92, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              vocab.word,
              style: const TextStyle(fontSize: 30, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      right: 8.0,
                    ),
                    child: Icon(
                      Icons.volume_up,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    vocab.pronunciation,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildTranslatedFlip(Vocabulary vocab) {
    return SizedBox(
      height: 300,
      child: Card(
        color: const Color.fromRGBO(74, 14, 92, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              vocab.word,
              style: const TextStyle(fontSize: 30, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                vocab.meaning,
                style: const TextStyle(
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
