import 'package:budgeting_app/models/category.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum IncomeType { netIncome, grossIncome }

class BudgetFormState extends Equatable {
  final double income;
  final IncomeType incomeType;
  final bool showCategories;
  final Map<Category, double> budgetItems;
  final double remainingIncome;

  const BudgetFormState({
    required this.income,
    required this.incomeType,
    required this.showCategories,
    required this.budgetItems,
    required this.remainingIncome,
  });

  BudgetFormState copyWith({
    double? income,
    IncomeType? incomeType,
    bool? showCategories,
    Map<Category, double>? budgetItems,
    double? remainingIncome,
  }) {
    return BudgetFormState(
      income: income ?? this.income,
      incomeType: incomeType ?? this.incomeType,
      showCategories: showCategories ?? this.showCategories,
      budgetItems: budgetItems ?? this.budgetItems,
      remainingIncome: remainingIncome ?? this.remainingIncome,
    );
  }

  @override
  List<Object> get props => [
        income,
        incomeType,
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
            incomeType: IncomeType.netIncome,
            showCategories: true,
            budgetItems: <Category, double>{},
            remainingIncome: 0,
          ),
        );

  void setIncome(double newIncome) => emit(state.copyWith(
        income: newIncome,
        remainingIncome: state.income -
            state.budgetItems.values.reduce((sum, element) => sum + element),
      ));

  void setIncomeType(IncomeType newType) => emit(state.copyWith(
        incomeType: newType,
      ));

  void toggleCategoirs() =>
      emit(state.copyWith(showCategories: !state.showCategories));

  void addCategory(Category newCategory, double amount) {
    Map<Category, double> newBudgetItems = Map.from(state.budgetItems);
    newBudgetItems[newCategory] = amount;
    emit(state.copyWith(budgetItems: newBudgetItems));
  }

  void deleteCategory(Category targetCategory) {
    Map<Category, double> newBudgetItems = Map.from(state.budgetItems);
    newBudgetItems.remove(targetCategory);
    emit(state.copyWith(budgetItems: newBudgetItems));
  }

  void editCategory(Category category, double newAmount) {
    Map<Category, double> newBudgetItems = Map.from(state.budgetItems);
    newBudgetItems[category] = newAmount;
    emit(state.copyWith(budgetItems: newBudgetItems));
  }
}
