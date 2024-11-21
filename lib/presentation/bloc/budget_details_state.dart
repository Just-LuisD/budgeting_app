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
  final List<Income> incomeList;
  final List<Expense> expenses;
  final int totalSpent;

  const BudgetDetailsState({
    this.budget,
    this.status = BudgetDetailsStatus.initial,
    this.categories = const [],
    this.incomeList = const [],
    this.expenses = const [],
    this.totalSpent = 0,
  });

  int getEffectiveIncome() {
    int totalIncome = getTotalIncome();
    return totalIncome > budget!.income ? totalIncome : budget!.income;
  }

  int getTotalIncome() {
    int totalIncome = 0;
    for (Income income in incomeList) {
      totalIncome += income.amount;
    }

    return totalIncome;
  }

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
      incomeList: income != null ? income() : this.incomeList,
      expenses: expenses != null ? expenses() : this.expenses,
      totalSpent: totalSpent != null ? totalSpent() : this.totalSpent,
    );
  }

  @override
  List<Object?> get props => [
        status,
        budget,
        categories,
        incomeList,
        expenses,
        totalSpent,
      ];
}
