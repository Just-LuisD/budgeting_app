import 'package:flutter/material.dart';

class AmountField extends StatelessWidget {
  final TextEditingController inputController;
  const AmountField({
    super.key,
    required this.inputController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      decoration: const InputDecoration(
        labelText: 'Amount',
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
