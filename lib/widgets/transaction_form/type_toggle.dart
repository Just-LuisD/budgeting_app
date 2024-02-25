import 'package:flutter/material.dart';

class TypeToggle extends StatefulWidget {
  const TypeToggle({super.key});

  @override
  State<TypeToggle> createState() => _TypeToggleState();
}

enum TransactionType { expense, income }

class _TypeToggleState extends State<TypeToggle> {
  TransactionType transactionType = TransactionType.expense;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      showSelectedIcon: false,
      segments: const [
        ButtonSegment(
          value: TransactionType.expense,
          icon: Icon(Icons.arrow_drop_down),
          label: Text("Expense"),
        ),
        ButtonSegment(
          value: TransactionType.income,
          icon: Icon(Icons.arrow_drop_up),
          label: Text("Income"),
        ),
      ],
      selected: <TransactionType>{transactionType},
      onSelectionChanged: (Set<TransactionType> newSelection) {
        setState(() {
          transactionType = newSelection.first;
        });
      },
    );
  }
}
