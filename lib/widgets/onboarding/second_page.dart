import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightGreen,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              "Give you budget a name",
            ),
            TextField()
          ],
        ));
  }
}
