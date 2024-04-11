import 'package:flutter/material.dart';

class PercentField extends StatelessWidget {
  final TextEditingController inputController;
  final String label;
  final bool enabled;
  const PercentField({
    super.key,
    required this.inputController,
    required this.label,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
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
            double.tryParse(value)! <= 0 ||
            double.tryParse(value)! > 100) {
          return 'Invalid Percentage';
        }
        return null;
      },
    );
  }
}
