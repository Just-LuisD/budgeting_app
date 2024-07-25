import 'package:budgeting_app/presentation/screens/expense_form_screen.dart';
import 'package:flutter/material.dart';

class ExpenseHeader extends StatelessWidget {
  final bool showingList;
  final Function onToggle;
  const ExpenseHeader({
    super.key,
    required this.showingList,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            onToggle();
          },
          icon: Icon(showingList == true
              ? Icons.arrow_drop_down
              : Icons.arrow_right_outlined),
        ),
        const Expanded(
          child: Text("Expenses"),
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => ExpenseFormScreen(
                budgetId: 0,
                categories: [],
              ),
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
