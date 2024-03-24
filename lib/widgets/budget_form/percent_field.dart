import 'package:flutter/material.dart';

class PercentField extends StatelessWidget {
  final TextEditingController inputController;
  final String label;
  const PercentField({
    super.key,
    required this.inputController,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      textAlign: TextAlign.end,
      decoration: InputDecoration(
        labelText: label,
        suffixText: "%",
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            double.tryParse(value) == null ||
            double.tryParse(value)! <= 0) {
          return 'Your transaction amount must be a positive value.';
        }
        return null;
      },
    );
  }
}
