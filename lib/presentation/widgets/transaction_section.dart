import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/domain/entities/income.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_bloc.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_event.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_state.dart';
import 'package:budgeting_app/presentation/widgets/transaction_header.dart';
import 'package:budgeting_app/presentation/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionSection extends StatefulWidget {
  const TransactionSection({super.key});

  @override
  State<TransactionSection> createState() => _TransactionSectionState();
}

class _TransactionSectionState extends State<TransactionSection> {
  bool _showList = true;

  void _toggleList() {
    setState(() {
      _showList = !_showList;
    });
  }

  void _addExpense(Expense expense) {
    context.read<BudgetDetailsBloc>().add(AddExpenseEvent(newExpense: expense));
  }

  void _deleteExpense(int expenseId) {
    context
        .read<BudgetDetailsBloc>()
        .add(DeleteExpenseEvent(expenseId: expenseId));
  }

  void _updateExpense(Expense newExpense) {
    context
        .read<BudgetDetailsBloc>()
        .add(UpdateExpenseEvent(updatedExpense: newExpense));
  }

  void _addIncome(Income income) {
    context.read<BudgetDetailsBloc>().add(AddIncomeEvent(newIncome: income));
  }

  void _deleteIncome(int incomeId) {
    context
        .read<BudgetDetailsBloc>()
        .add(DeleteIncomeEvent(incomeId: incomeId));
  }

  void _updateIncome(Income newIncome) {
    context
        .read<BudgetDetailsBloc>()
        .add(UpdateIncomeEvent(updatedIncome: newIncome));
  }

  List<Category> _getCategories() {
    return context.read<BudgetDetailsBloc>().state.categories;
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
          BlocBuilder<BudgetDetailsBloc, BudgetDetailsState>(
              builder: (context, state) {
            return TransactionList(
              expenseList: state.expenses,
              incomeList: state.income,
              deleteExpense: _deleteExpense,
              updateExpense: _updateExpense,
              deleteIncome: _deleteIncome,
              updateIncome: _updateIncome,
              categories: state.categories,
            );
          })
      ],
    );
  }
}
