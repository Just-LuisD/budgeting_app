import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  const ExpenseList({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, idx) {
          return ExpenseItem(expense: expenses[idx]);
        },
      ),
    );
  }
}

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense.title),
      subtitle: Text(expense.amount.toString()),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.delete),
      ),
    );
  }
}
