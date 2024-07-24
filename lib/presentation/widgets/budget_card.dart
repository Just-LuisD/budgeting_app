import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:budgeting_app/presentation/screens/budget_form_screen.dart';
import 'package:flutter/material.dart';

class BudgetCard extends StatelessWidget {
  final Budget budget;

  const BudgetCard({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(budget.name),
      subtitle: Text('Income: \$${budget.income.toStringAsFixed(2)}'),
      trailing: IconButton(
          onPressed: () {
            // TODO: delete budget
          },
          icon: const Icon(Icons.delete)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BudgetFormScreen(budget: budget),
          ),
        );
      },
    );
  }
}
