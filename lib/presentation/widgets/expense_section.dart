import 'package:budgeting_app/data/repositories/category_repository_impl.dart';
import 'package:budgeting_app/data/repositories/expense_repository_impl.dart';
import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/presentation/widgets/expense_header.dart';
import 'package:budgeting_app/presentation/widgets/expense_list.dart';
import 'package:flutter/material.dart';

class ExpenseSection extends StatefulWidget {
  final int budgetId;

  const ExpenseSection({
    super.key,
    required this.budgetId,
  });

  @override
  State<ExpenseSection> createState() => _ExpenseSectionState();
}

class _ExpenseSectionState extends State<ExpenseSection> {
  bool _showList = true;
  ExpenseRepositoryImpl expenseRepository = ExpenseRepositoryImpl();
  CategoryRepositoryImpl categoryRepository = CategoryRepositoryImpl();

  void _toggleList() {
    setState(() {
      _showList = !_showList;
    });
  }

  void _addExpense(Expense expense) {
    expenseRepository.insertExpense(expense.copy(budgetId: widget.budgetId));
    setState(() {});
  }

  void _deleteExpense(int expenseId) {
    expenseRepository.deleteExpense(expenseId);
    setState(() {});
  }

  void _updateExpense(Expense newExpense) {
    expenseRepository.updateExpense(newExpense);
    setState(() {});
  }

  Future<List<Category>> _getCategories() async {
    return categoryRepository.getCategoriesByBudgetId(widget.budgetId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExpenseHeader(
          showingList: _showList,
          onToggle: _toggleList,
          onAdd: _addExpense,
          getCategories: _getCategories,
        ),
        if (_showList)
          FutureBuilder(
            future: expenseRepository.getExpensesByBudgetId(widget.budgetId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ExpenseList(
                  expenses: snapshot.data!,
                  deleteItem: _deleteExpense,
                  updateItem: _updateExpense,
                  getCategories: _getCategories,
                );
              }
              return Container();
            },
          ),
      ],
    );
  }
}
