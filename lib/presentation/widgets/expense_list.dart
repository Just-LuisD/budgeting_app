import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/presentation/widgets/expense_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final curencyFormatter = NumberFormat.simpleCurrency();

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(int) deleteItem;
  final void Function(Expense) updateItem;
  final Future<List<Category>> Function() getCategories;

  const ExpenseList({
    super.key,
    required this.expenses,
    required this.deleteItem,
    required this.updateItem,
    required this.getCategories,
  });

  @override
  Widget build(BuildContext context) {
    return expenses.isEmpty
        ? const Text("No Expenses Found")
        : Flexible(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: expenses.length,
              itemBuilder: (context, idx) {
                return ExpenseItem(
                  expense: expenses[idx],
                  onDelete: deleteItem,
                  onUpdate: updateItem,
                  getCategories: getCategories,
                );
              },
            ),
          );
  }
}

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final void Function(int) onDelete;
  final void Function(Expense) onUpdate;
  final Future<List<Category>> Function() getCategories;

  const ExpenseItem({
    super.key,
    required this.expense,
    required this.onDelete,
    required this.onUpdate,
    required this.getCategories,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense.title),
      subtitle: Text(curencyFormatter.format(expense.amount / 100)),
      trailing: IconButton(
        onPressed: () {
          onDelete(expense.id!);
        },
        icon: const Icon(Icons.delete),
      ),
      onTap: () {
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
                  expense: expense,
                  onSubmit: onUpdate,
                  categories: categories,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
