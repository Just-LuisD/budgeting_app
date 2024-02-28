import 'package:budgeting_app/models/transaction.dart';
import 'package:flutter/material.dart';

class TypeToggle extends StatelessWidget {
  final TransactionType active;
  final Function onClick;
  const TypeToggle({
    super.key,
    required this.active,
    required this.onClick,
  });

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
      selected: <TransactionType>{active},
      onSelectionChanged: (Set<TransactionType> newSelection) {
        onClick(newSelection.first);
      },
    );
  }
}
