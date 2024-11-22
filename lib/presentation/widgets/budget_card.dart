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
    return GestureDetector(
      child: SizedBox(
        height: 85,
        child: Card(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        budget.name,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Exp Income: ${curencyFormatter.format(budget.income / 100)}',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Icon(Icons.arrow_right),
              Text("Income \$8,000.00"),
              PopupMenuButton<MenuItems>(
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
            ],
          ),
        ),
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
