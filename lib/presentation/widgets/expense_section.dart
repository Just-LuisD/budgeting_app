import 'package:budgeting_app/presentation/widgets/expense_header.dart';
import 'package:budgeting_app/presentation/widgets/expense_list.dart';
import 'package:budgeting_app/test_data.dart';
import 'package:flutter/material.dart';

class ExpenseSection extends StatefulWidget {
  const ExpenseSection({super.key});

  @override
  State<ExpenseSection> createState() => _ExpenseSectionState();
}

class _ExpenseSectionState extends State<ExpenseSection> {
  bool _showList = true;

  void _toggleList() {
    setState(() {
      _showList = !_showList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExpenseHeader(
          showingList: _showList,
          onToggle: _toggleList,
        ),
        if (_showList)
          ExpenseList(
            expenses: testExpesnses1,
          ),
      ],
    );
  }
}
