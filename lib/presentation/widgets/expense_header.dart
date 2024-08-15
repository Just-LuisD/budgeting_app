import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/presentation/widgets/expense_form.dart';
import 'package:flutter/material.dart';

class ExpenseHeader extends StatelessWidget {
  final bool showingList;
  final Function onToggle;
  final void Function(Expense) onAdd;
  final Future<List<Category>> Function() getCategories;

  const ExpenseHeader({
    super.key,
    required this.showingList,
    required this.onToggle,
    required this.onAdd,
    required this.getCategories,
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
            getCategories().then(
              (categories) {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: ExpenseForm(
                      onSubmit: onAdd,
                      categories: categories,
                    ),
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
