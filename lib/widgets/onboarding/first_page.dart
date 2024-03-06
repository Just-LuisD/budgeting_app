import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(255, 247, 239, 229),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              "Welcome to Zen",
            ),
            Text(
                textAlign: TextAlign.center,
                style: TextStyle(),
                "Let's start out by building a budget"),
          ],
        ));
  }
}
