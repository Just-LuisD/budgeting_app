import 'package:flutter/material.dart';

class AmountField extends StatelessWidget {
  final TextEditingController inputController;
  final String label;
  final bool enabled;

  const AmountField({
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
      decoration: InputDecoration(
        labelText: label,
        prefixText: '\$',
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
