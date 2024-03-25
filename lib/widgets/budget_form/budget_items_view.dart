import 'package:budgeting_app/widgets/budget_form/budget_item.dart';
import 'package:flutter/material.dart';

class BudgetItemsView extends StatelessWidget {
  final void Function() toggleCategories;
  final void Function() showBudgetItemForm;
  final bool showCategories;
  final List<BudgetItem> budgetItems;
  const BudgetItemsView({
    super.key,
    required this.toggleCategories,
    required this.showBudgetItemForm,
    required this.showCategories,
    required this.budgetItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: toggleCategories,
              icon: const Icon(Icons.arrow_drop_down),
            ),
            const Spacer(),
            IconButton(
              alignment: AlignmentDirectional.centerEnd,
              onPressed: showBudgetItemForm,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        SizedBox(
          height: 280,
          child: Center(
            child: ListView(
              children: [
                if (showCategories)
                  if (budgetItems.isNotEmpty)
                    ...(budgetItems)
                  else
                    const Text(
                      "No Budget Items Found",
                      textAlign: TextAlign.center,
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
