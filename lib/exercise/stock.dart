import 'package:flutter/material.dart';

class MyStock extends StatelessWidget {
  const MyStock({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AAPL',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Apple Inc.',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black45,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                '\$142.90',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '+0.63%',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromRGBO(39, 206, 146, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }
}
