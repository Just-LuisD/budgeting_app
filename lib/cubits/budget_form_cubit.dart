import 'package:budgeting_app/models/category.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetFormState extends Equatable {
  final double income;
  final bool showCategories;
  final Map<Category, double> budgetItems;
  final double remainingIncome;

  const BudgetFormState({
    required this.income,
    required this.showCategories,
    required this.budgetItems,
    required this.remainingIncome,
  });

  BudgetFormState copyWith({
    double? income,
    bool? showCategories,
    Map<Category, double>? budgetItems,
    double? remainingIncome,
  }) {
    return BudgetFormState(
      income: income ?? this.income,
      showCategories: showCategories ?? this.showCategories,
      budgetItems: budgetItems ?? this.budgetItems,
      remainingIncome: remainingIncome ?? this.remainingIncome,
    );
  }

  @override
  List<Object> get props => [
        income,
        showCategories,
        budgetItems,
        remainingIncome,
      ];
}

class BudgetFormCubit extends Cubit<BudgetFormState> {
  BudgetFormCubit()
      : super(
          const BudgetFormState(
            income: 0,
            showCategories: true,
            budgetItems: <Category, double>{},
            remainingIncome: 0,
          ),
        );

  void setIncome(double newIncome) {
    double sum = 0;
    for (double amount in state.budgetItems.values) {
      sum += amount;
    }
    double newRemainingIncome = newIncome - sum;
    emit(state.copyWith(
      income: newIncome,
      remainingIncome: newRemainingIncome,
    ));
  }

  void toggleShowCategories() =>
      emit(state.copyWith(showCategories: !state.showCategories));

  void addCategory(Category newCategory, double amount) {
    Map<Category, double> newBudgetItems = Map.from(state.budgetItems);
    newBudgetItems[newCategory] = amount;
    double sum = 0;
    for (double amount in newBudgetItems.values) {
      sum += amount;
    }
    double newRemainingIncome = state.income - sum;
    emit(state.copyWith(
      budgetItems: newBudgetItems,
      remainingIncome: newRemainingIncome,
    ));
  }

  void deleteCategory(Category targetCategory) {
    Map<Category, double> newBudgetItems = Map.from(state.budgetItems);
    newBudgetItems.remove(targetCategory);
    double sum = 0;
    for (double amount in newBudgetItems.values) {
      sum += amount;
    }
    double newRemainingIncome = state.income - sum;
    emit(state.copyWith(
      budgetItems: newBudgetItems,
      remainingIncome: newRemainingIncome,
    ));
  }

  void editCategory(
      Category originalCategory, Category category, double newAmount) {
    Map<Category, double> newBudgetItems = Map.from(state.budgetItems);
    if (originalCategory.name != category.name) {
      newBudgetItems.remove(originalCategory);
    }
    newBudgetItems[category] = newAmount;
    double sum = 0;
    for (double amount in newBudgetItems.values) {
      sum += amount;
    }
    double newRemainingIncome = state.income - sum;
    emit(state.copyWith(
      budgetItems: newBudgetItems,
      remainingIncome: newRemainingIncome,
    ));
  }
}
