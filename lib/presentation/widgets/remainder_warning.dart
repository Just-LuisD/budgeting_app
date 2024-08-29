import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RemainderWarning extends StatelessWidget {
  final int remainder;
  final void Function(int) onAllocate;
  const RemainderWarning({
    super.key,
    required this.remainder,
    required this.onAllocate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "WARNING",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                  "You have ${NumberFormat.simpleCurrency().format(remainder / 100)} left to allocated in your budget."),
              Container(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    onAllocate(remainder);
                  },
                  child: const Text("Allocate"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
