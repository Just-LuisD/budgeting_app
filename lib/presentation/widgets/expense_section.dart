import 'package:budgeting_app/presentation/widgets/expense_header.dart';
import 'package:flutter/material.dart';

class ExpenseSection extends StatefulWidget {
  const ExpenseSection({super.key});

  @override
  State<ExpenseSection> createState() => _ExpenseSectionState();
}

class _ExpenseSectionState extends State<ExpenseSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ExpenseHeader(),
        ],
      ),
    );
  }
}
