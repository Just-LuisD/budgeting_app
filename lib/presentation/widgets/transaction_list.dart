import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/domain/entities/income.dart';
import 'package:budgeting_app/presentation/widgets/expense_form.dart';
import 'package:budgeting_app/presentation/widgets/income_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final curencyFormatter = NumberFormat.simpleCurrency();
final dateFormatter = DateFormat("MMMd");

class TransactionList extends StatelessWidget {
  final List<Income> incomeList;
  final List<Expense> expenseList;
  final void Function(int) deleteIncome;
  final void Function(Income) updateIncome;
  final void Function(int) deleteExpense;
  final void Function(Expense) updateExpense;
  final List<Category> categories;

  const TransactionList({
    super.key,
    required this.incomeList,
    required this.expenseList,
    required this.deleteIncome,
    required this.deleteExpense,
    required this.updateExpense,
    required this.updateIncome,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      ...incomeList.map(
        (income) => IncomeItem(
          income: income,
          onDelete: deleteIncome,
          onUpdate: updateIncome,
        ),
      ),
      ...expenseList.map(
        (expense) => ExpenseItem(
          expense: expense,
          onDelete: deleteExpense,
          onUpdate: updateExpense,
          categories: categories,
        ),
      )
    ];
    return items.isEmpty
        ? const Text("No Transactions Found")
        : ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, idx) {
              return items[idx];
            },
          );
  }
}

class IncomeItem extends StatelessWidget {
  final Income income;
  final void Function(int) onDelete;
  final void Function(Income) onUpdate;
  const IncomeItem({
    super.key,
    required this.income,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(income.title),
      subtitle: Text(dateFormatter.format(DateTime.parse(income.date))),
      trailing: Text(
        "+${curencyFormatter.format(income.amount / 100)}",
        style: const TextStyle(
          color: Colors.green,
          fontSize: 14,
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: IncomeForm(
                onSubmit: onUpdate,
                income: income,
                onDelete: onDelete,
              ),
            );
          },
        );
      },
    );
  }
}

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final void Function(int) onDelete;
  final void Function(Expense) onUpdate;
  final List<Category> categories;

  const ExpenseItem({
    super.key,
    required this.expense,
    required this.onDelete,
    required this.onUpdate,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense.title),
      subtitle: Text(
        "Miscellaneous\n${dateFormatter.format(DateTime.parse(expense.date))}",
      ),
      trailing: Text(
        "-${curencyFormatter.format(expense.amount / 100)}",
        style: const TextStyle(
          color: Colors.red,
          fontSize: 14,
        ),
      ),
      onTap: () {
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
              onDelete: onDelete,
              categories: categories,
            ),
          ),
        );
      },
    );
  }
}
