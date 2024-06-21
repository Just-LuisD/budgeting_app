import 'package:budgeting_app/clean_architecture/domain/entities/budget.dart';
import 'package:equatable/equatable.dart';

abstract class BudgetState extends Equatable {
  @override
  List<Object> get props => [];
}

class BudgetInitial extends BudgetState {}

class BudgetLoading extends BudgetState {}

class BudgetLoaded extends BudgetState {
  final List<Budget> budgets;

  BudgetLoaded(this.budgets);

  @override
  List<Object> get props => [budgets];
}

class BudgetError extends BudgetState {
  final String message;

  BudgetError(this.message);

  @override
  List<Object> get props => [message];
}
