import 'package:flutter/material.dart';

class StartBudget extends StatelessWidget {
  const StartBudget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            "No Budget Found",
          ),
          const Text(
              textAlign: TextAlign.center,
              style: TextStyle(),
              "It looks like you do not have a budget yet. No worries we can help you create one!"),
          ElevatedButton(
              onPressed: () => {}, child: const Text("Lets Get Started!"))
        ],
      ),
    );
  }
}
