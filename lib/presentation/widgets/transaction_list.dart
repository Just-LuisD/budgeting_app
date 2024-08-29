import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/domain/entities/income.dart';
import 'package:budgeting_app/presentation/widgets/expense_form.dart';
import 'package:budgeting_app/presentation/widgets/income_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final curencyFormatter = NumberFormat.simpleCurrency();
final dateFormatter = DateFormat("yMd");

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
    List<Widget> items = [];
    if (incomeList.isNotEmpty || expenseList.isNotEmpty) {
      var sortedIncome = incomeList.toList()
        ..sort(
            (a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
      var sortedExpenses = expenseList.toList()
        ..sort(
            (a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
      while (sortedIncome.isNotEmpty && sortedExpenses.isNotEmpty) {
        int result = DateTime.parse(sortedIncome[0].date)
            .compareTo(DateTime.parse(sortedExpenses[0].date));
        if (result >= 0) {
          items.add(
            IncomeItem(
              income: sortedIncome[0],
              onDelete: deleteIncome,
              onUpdate: updateIncome,
            ),
          );
          sortedIncome.removeAt(0);
        } else {
          items.add(
            ExpenseItem(
              expense: sortedExpenses[0],
              onDelete: deleteExpense,
              onUpdate: updateExpense,
              categories: categories,
            ),
          );
          sortedExpenses.removeAt(0);
        }
      }
      if (sortedIncome.isNotEmpty) {
        items = [
          ...items,
          ...sortedIncome.map(
            (income) => IncomeItem(
              income: income,
              onDelete: deleteIncome,
              onUpdate: updateIncome,
            ),
          )
        ];
      } else {
        items = [
          ...items,
          ...sortedExpenses.map(
            (expense) => ExpenseItem(
              expense: expense,
              onDelete: deleteExpense,
              onUpdate: updateExpense,
              categories: categories,
            ),
          )
        ];
      }
    }

    return items.isEmpty
        ? const Center(child: Text("No Transactions Found"))
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
    String categoryName =
        categories.firstWhere((e) => e.id! == expense.categoryId).name;

    return ListTile(
      title: Text(expense.title),
      subtitle: Text(
        "$categoryName\n${dateFormatter.format(DateTime.parse(expense.date))}",
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
