import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:budgeting_app/presentation/screens/budget_details_screen.dart';
import 'package:flutter/material.dart';

class BudgetCard extends StatelessWidget {
  final Budget budget;
  final void Function() onDelete;

  const BudgetCard({
    super.key,
    required this.budget,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(budget.name),
      subtitle: Text('Expected Income: \$${budget.income.toStringAsFixed(2)}'),
      trailing: IconButton(
        onPressed: onDelete,
        icon: const Icon(Icons.delete),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BudgetDetailsScreen(budget: budget),
          ),
        );
      },
    );
  }
}
