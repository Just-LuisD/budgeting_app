import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/domain/entities/income.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_bloc.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_event.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_state.dart';
import 'package:budgeting_app/presentation/widgets/transaction_bottom_sheet.dart';
import 'package:budgeting_app/presentation/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionSection extends StatefulWidget {
  const TransactionSection({super.key});

  @override
  State<TransactionSection> createState() => _TransactionSectionState();
}

class _TransactionSectionState extends State<TransactionSection> {
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
    return BlocBuilder<BudgetDetailsBloc, BudgetDetailsState>(
      builder: (context, state) {
        return Stack(
          children: [
            TransactionList(
              expenseList: state.expenses,
              incomeList: state.incomeList,
              deleteExpense: _deleteExpense,
              updateExpense: _updateExpense,
              deleteIncome: _deleteIncome,
              updateIncome: _updateIncome,
              categories: state.categories,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  final categories = _getCategories();
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: TransactionBottomSheet(
                        addExpense: _addExpense,
                        addIncome: _addIncome,
                        categories: categories,
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.add,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
