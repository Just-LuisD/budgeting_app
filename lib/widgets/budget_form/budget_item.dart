import 'package:budgeting_app/models/category.dart';
import 'package:flutter/material.dart';

class BudgetItem extends StatelessWidget {
  final Category category;
  final double amount;
  final Function(Category, double) onEdit;
  const BudgetItem({
    super.key,
    required this.category,
    required this.amount,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Image.asset(
            category.image,
            scale: 1.5,
          ),
        ),
        title: Text(category.name),
        subtitle: Text("\$$amount"),
        trailing: IconButton(
          onPressed: () => {onEdit(category, amount)},
          icon: Icon(Icons.edit),
        ),
      ),
    );
  }
}
