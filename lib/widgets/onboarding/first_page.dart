import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

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
              "Welcome to [Insert Name]",
            ),
            Text(
                textAlign: TextAlign.center,
                style: TextStyle(),
                "Let's start out by building a budget"),
          ],
        ));
  }
}
