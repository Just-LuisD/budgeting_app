import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/domain/entities/income.dart';
import 'package:equatable/equatable.dart';

final class BudgetDetailsEvent extends Equatable {
  const BudgetDetailsEvent();

  @override
  List<Object?> get props => [];
}

final class UpdateBudgetEvent extends BudgetDetailsEvent {
  final Budget updatedBudget;

  const UpdateBudgetEvent({
    required this.updatedBudget,
  });
}

final class AddIncomeEvent extends BudgetDetailsEvent {
  final Income newIncome;

  const AddIncomeEvent({
    required this.newIncome,
  });
}

final class AddExpenseEvent extends BudgetDetailsEvent {
  final Expense newExpense;

  const AddExpenseEvent({
    required this.newExpense,
  });
}

final class AddCategoryEvent extends BudgetDetailsEvent {
  final Category newCategory;

  const AddCategoryEvent({
    required this.newCategory,
  });
}

final class UpdateIncomeEvent extends BudgetDetailsEvent {
  final Income updatedIncome;

  const UpdateIncomeEvent({
    required this.updatedIncome,
  });
}

final class UpdateExpenseEvent extends BudgetDetailsEvent {
  final Expense updatedExpense;

  const UpdateExpenseEvent({
    required this.updatedExpense,
  });
}

final class UpdateCategoryEvent extends BudgetDetailsEvent {
  final Category updatedCategory;

  const UpdateCategoryEvent({
    required this.updatedCategory,
  });
}

final class DeleteIncomeEvent extends BudgetDetailsEvent {
  final int incomeId;

  const DeleteIncomeEvent({
    required this.incomeId,
  });
}

final class DeleteExpenseEvent extends BudgetDetailsEvent {
  final int expenseId;

  const DeleteExpenseEvent({
    required this.expenseId,
  });
}

final class DeleteCategoryEvent extends BudgetDetailsEvent {
  final int categoryId;

  const DeleteCategoryEvent({
    required this.categoryId,
  });
}
