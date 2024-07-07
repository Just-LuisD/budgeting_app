import 'package:budgeting_app/clean_architecture/domain/entities/budget.dart';
import 'package:equatable/equatable.dart';

abstract class BudgetEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchBudgets extends BudgetEvent {}

class AddBudget extends BudgetEvent {
  final Budget budget;

  AddBudget(this.budget);

  @override
  List<Object> get props => [budget];
}

class UpdateBudget extends BudgetEvent {
  final Budget budget;

  UpdateBudget(this.budget);

  @override
  List<Object> get props => [budget];
}

class DeleteBudget extends BudgetEvent {
  final int id;

  DeleteBudget(this.id);

  @override
  List<Object> get props => [id];
}
