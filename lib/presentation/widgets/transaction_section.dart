import 'package:budgeting_app/data/repositories/category_repository_impl.dart';
import 'package:budgeting_app/data/repositories/expense_repository_impl.dart';
import 'package:budgeting_app/data/repositories/income_repository_impl.dart';
import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/domain/entities/income.dart';
import 'package:budgeting_app/presentation/widgets/transaction_header.dart';
import 'package:budgeting_app/presentation/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class TransactionSection extends StatefulWidget {
  final int budgetId;

  const TransactionSection({
    super.key,
    required this.budgetId,
  });

  @override
  State<TransactionSection> createState() => _TransactionSectionState();
}

class _TransactionSectionState extends State<TransactionSection> {
  bool _showList = true;
  ExpenseRepositoryImpl expenseRepository = ExpenseRepositoryImpl();
  CategoryRepositoryImpl categoryRepository = CategoryRepositoryImpl();
  IncomeRepositoryImpl incomeRepository = IncomeRepositoryImpl();

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

  void _addIncome(Income income) {
    incomeRepository.insertIncome(income.copy(budgetId: widget.budgetId));
    setState(() {});
  }

  void _deleteIncome(int incomeId) {
    incomeRepository.deleteIncome(incomeId);
    setState(() {});
  }

  void _updateIncome(Income newIncome) {
    incomeRepository.updateIncome(newIncome);
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
        TransactionHeader(
          showingList: _showList,
          onToggle: _toggleList,
          addExpense: _addExpense,
          addIncome: _addIncome,
          getCategories: _getCategories,
        ),
        if (_showList)
          FutureBuilder(
            future: Future.wait([
              expenseRepository.getExpensesByBudgetId(widget.budgetId),
              incomeRepository.getBudgetIncome(widget.budgetId),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return TransactionList(
                  expenseList: snapshot.data![0] as List<Expense>,
                  incomeList: snapshot.data![1] as List<Income>,
                  deleteExpense: _deleteExpense,
                  updateExpense: _updateExpense,
                  deleteIncome: _deleteIncome,
                  updateIncome: _updateIncome,
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
