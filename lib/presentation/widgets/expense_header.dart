import 'package:budgeting_app/presentation/screens/expense_form_screen.dart';
import 'package:flutter/material.dart';

class ExpenseHeader extends StatelessWidget {
  const ExpenseHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(true ? Icons.arrow_drop_down : Icons.arrow_right_outlined),
        ),
        Expanded(
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
