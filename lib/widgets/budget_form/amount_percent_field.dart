import 'package:flutter/material.dart';

class AmountPercentField extends StatelessWidget {
  final TextEditingController percentController;
  final TextEditingController amountController;
  final bool isPercent;
  final void Function(String?) onChanged;
  final void Function(bool?) onPercent;
  final void Function(bool?) onAmount;

  const AmountPercentField({
    super.key,
    required this.amountController,
    required this.percentController,
    required this.isPercent,
    required this.onChanged,
    required this.onAmount,
    required this.onPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: amountController,
            enabled: !isPercent,
            decoration: const InputDecoration(
              labelText: "Amount",
              prefixText: '\$',
            ),
            keyboardType: TextInputType.number,
            onChanged: onChanged,
          ),
        ),
        Checkbox(
          value: !isPercent,
          onChanged: onAmount,
        ),
        Expanded(
          child: TextFormField(
            controller: percentController,
            enabled: isPercent,
            textAlign: TextAlign.end,
            decoration: const InputDecoration(
              labelText: "Percent",
              suffixText: "%",
            ),
            keyboardType: TextInputType.number,
            onChanged: onChanged,
          ),
        ),
        Checkbox(
          value: isPercent,
          onChanged: onPercent,
        ),
      ],
    );
  }
}
