import 'package:flutter/material.dart';

class PendingSwitch extends StatelessWidget {
  final bool isPending;
  final void Function(bool) onChange;
  const PendingSwitch({
    super.key,
    required this.isPending,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch(value: isPending, onChanged: onChange),
        const Text("Pending"),
      ],
    );
  }
}
