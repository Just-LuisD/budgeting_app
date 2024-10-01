import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:budgeting_app/presentation/screens/budget_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final curencyFormatter = NumberFormat.simpleCurrency();

enum MenuItems { copy, delete }

class BudgetCard extends StatelessWidget {
  final Budget budget;
  final void Function() onDelete;
  final void Function() onCopy;

  const BudgetCard({
    super.key,
    required this.budget,
    required this.onDelete,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(budget.name),
      subtitle: Text(
          'Expected Income: ${curencyFormatter.format(budget.income / 100)}'),
      trailing: PopupMenuButton<MenuItems>(
        onSelected: (value) {
          switch (value) {
            case MenuItems.copy:
              onCopy();
              break;
            case MenuItems.delete:
              onDelete();
              break;
          }
        },
        itemBuilder: (context) {
          return [
            const PopupMenuItem(
              value: MenuItems.copy,
              child: Text("copy"),
            ),
            const PopupMenuItem(
              value: MenuItems.delete,
              child: Text("delete"),
            ),
          ];
        },
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
