import 'package:budgeting_app/presentation/widgets/expense_form_screen.dart';
import 'package:budgeting_app/test_data.dart';
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
              isScrollControlled: true,
              context: context,
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ExpenseFormScreen(
                  budgetId: 0,
                  categories: testCategories1,
                ),
              ),
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
