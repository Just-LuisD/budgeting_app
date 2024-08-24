import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/domain/entities/income.dart';
import 'package:budgeting_app/presentation/widgets/expense_form.dart';
import 'package:budgeting_app/presentation/widgets/income_form.dart';
import 'package:flutter/material.dart';

enum TransactionType { income, expense }

class TransactionBottomSheet extends StatefulWidget {
  final void Function(Expense) addExpense;
  final void Function(Income) addIncome;
  final List<Category> categories;
  const TransactionBottomSheet({
    super.key,
    required this.addExpense,
    required this.addIncome,
    required this.categories,
  });

  @override
  State<TransactionBottomSheet> createState() => _TransactionBottomSheetState();
}

class _TransactionBottomSheetState extends State<TransactionBottomSheet> {
  TransactionType type = TransactionType.expense;

  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (type) {
      case TransactionType.income:
        content = IncomeForm(onSubmit: widget.addIncome);
      case TransactionType.expense:
        content = ExpenseForm(
          categories: widget.categories,
          onSubmit: widget.addExpense,
        );
    }

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SegmentedButton<TransactionType>(
                segments: const [
                  ButtonSegment(
                      value: TransactionType.expense,
                      label: Text("Expense"),
                      icon: Icon(Icons.arrow_drop_down)),
                  ButtonSegment(
                      value: TransactionType.income,
                      label: Text("Income"),
                      icon: Icon(Icons.arrow_drop_up)),
                ],
                showSelectedIcon: false,
                selected: {type},
                onSelectionChanged: (newSelection) {
                  setState(() {
                    type = newSelection.first;
                  });
                },
              ),
            ),
            content,
          ],
        ),
      ),
    );
  }
}
