import 'package:budgeting_app/clean_architecture/domain/entities/expense.dart';
import 'package:equatable/equatable.dart';

abstract class ExpenseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchExpenses extends ExpenseEvent {
  final int budgetId;

  FetchExpenses(this.budgetId);

  @override
  List<Object> get props => [budgetId];
}

class AddExpense extends ExpenseEvent {
  final Expense expense;

  AddExpense(this.expense);

  @override
  List<Object> get props => [expense];
}

class UpdateExpense extends ExpenseEvent {
  final Expense expense;

  UpdateExpense(this.expense);

  @override
  List<Object> get props => [expense];
}

class DeleteExpense extends ExpenseEvent {
  final Expense expense;

  DeleteExpense(this.expense);

  @override
  List<Object> get props => [expense];
}
