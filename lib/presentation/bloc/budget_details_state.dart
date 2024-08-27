import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/domain/entities/income.dart';
import 'package:equatable/equatable.dart';

enum BudgetDetailsStatus { initial, loading, success, failure }

final class BudgetDetailsState extends Equatable {
  final BudgetDetailsStatus status;
  final Budget? budget;
  final List<Category> categories;
  final List<Income> income;
  final List<Expense> expenses;
  final int totalSpent;

  const BudgetDetailsState({
    this.budget,
    this.status = BudgetDetailsStatus.initial,
    this.categories = const [],
    this.income = const [],
    this.expenses = const [],
    this.totalSpent = 0,
  });

  BudgetDetailsState copyWith({
    BudgetDetailsStatus Function()? status,
    Budget Function()? budget,
    List<Category> Function()? categories,
    List<Income> Function()? income,
    List<Expense> Function()? expenses,
    int Function()? totalSpent,
  }) {
    return BudgetDetailsState(
      status: status != null ? status() : this.status,
      budget: budget != null ? budget() : this.budget,
      categories: categories != null ? categories() : this.categories,
      income: income != null ? income() : this.income,
      expenses: expenses != null ? expenses() : this.expenses,
      totalSpent: totalSpent != null ? totalSpent() : this.totalSpent,
    );
  }

  @override
  List<Object?> get props => [
        status,
        budget,
        categories,
        income,
        expenses,
        totalSpent,
      ];
}
