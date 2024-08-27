import 'package:bloc/bloc.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/domain/repositories/budget_repository.dart';
import 'package:budgeting_app/domain/repositories/category_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_repository.dart';
import 'package:budgeting_app/domain/repositories/income_repository.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_state.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_event.dart';

class BudgetDetailsBloc extends Bloc<BudgetDetailsEvent, BudgetDetailsState> {
  final int budgetId;
  final BudgetRepository budgetRepository;
  final IncomeRepository incomeRepository;
  final ExpenseRepository expenseRepository;
  final CategoryRepository categoryRepository;

  BudgetDetailsBloc({
    required this.budgetId,
    required this.budgetRepository,
    required this.categoryRepository,
    required this.expenseRepository,
    required this.incomeRepository,
  }) : super(const BudgetDetailsState()) {
    on<FetchBudgetDetailsEvent>(_onFetchBudgetDetails);
    on<UpdateBudgetEvent>(_onUpdateBudget);
    on<AddIncomeEvent>(_onAddIncome);
    on<AddExpenseEvent>(_onAddExpense);
    on<AddCategoryEvent>(_onAddCategory);
    on<UpdateIncomeEvent>(_onUpdateIncome);
    on<UpdateExpenseEvent>(_onUpdateExpense);
    on<UpdateCategoryEvent>(_onUpdateCategory);
    on<DeleteIncomeEvent>(_onDeleteIncome);
    on<DeleteExpenseEvent>(_onDeleteExpense);
    on<DeleteCategoryEvent>(_onDeleteCategory);
  }

  Future<void> _onFetchBudgetDetails(
    FetchBudgetDetailsEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    final budget = await budgetRepository.getBudgetById(budgetId);
    final categories =
        await categoryRepository.getCategoriesByBudgetId(budgetId);
    final income = await incomeRepository.getBudgetIncome(budgetId);
    final expenses = await expenseRepository.getExpensesByBudgetId(budgetId);
    int totalSpent = 0;
    for (Expense expense in expenses) {
      totalSpent += expense.amount;
    }

    emit(state.copyWith(
      status: () => BudgetDetailsStatus.success,
      budget: () => budget,
      categories: () => categories,
      income: () => income,
      expenses: () => expenses,
      totalSpent: () => totalSpent,
    ));
  }

  Future<void> _onUpdateBudget(
    UpdateBudgetEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await budgetRepository.updateBudget(event.updatedBudget);
    final result =
        await budgetRepository.getBudgetById(event.updatedBudget.id!);
    emit(state.copyWith(budget: () => result));
  }

  Future<void> _onAddIncome(
    AddIncomeEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await incomeRepository
        .insertIncome(event.newIncome.copy(budgetId: budgetId));
    final result = await incomeRepository.getBudgetIncome(budgetId);
    emit(state.copyWith(income: () => result));
  }

  Future<void> _onAddExpense(
    AddExpenseEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await expenseRepository
        .insertExpense(event.newExpense.copy(budgetId: budgetId));
    final result = await expenseRepository.getExpensesByBudgetId(budgetId);
    int totalSpent = 0;
    for (Expense expense in result) {
      totalSpent += expense.amount;
    }

    emit(state.copyWith(
      expenses: () => result,
      totalSpent: () => totalSpent,
    ));
  }

  Future<void> _onAddCategory(
    AddCategoryEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await categoryRepository
        .insertCategory(event.newCategory.copy(budgetId: budgetId));
    final result = await categoryRepository.getCategoriesByBudgetId(budgetId);
    emit(state.copyWith(categories: () => result));
  }

  Future<void> _onUpdateIncome(
    UpdateIncomeEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await incomeRepository.updateIncome(event.updatedIncome);
    final result = await incomeRepository.getBudgetIncome(budgetId);
    emit(state.copyWith(income: () => result));
  }

  Future<void> _onUpdateExpense(
    UpdateExpenseEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await expenseRepository.updateExpense(event.updatedExpense);
    final result = await expenseRepository.getExpensesByBudgetId(budgetId);
    int totalSpent = 0;
    for (Expense expense in result) {
      totalSpent += expense.amount;
    }

    emit(state.copyWith(
      expenses: () => result,
      totalSpent: () => totalSpent,
    ));
  }

  Future<void> _onUpdateCategory(
    UpdateCategoryEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await categoryRepository.updateCategory(event.updatedCategory);
    final result = await categoryRepository.getCategoriesByBudgetId(budgetId);
    emit(state.copyWith(categories: () => result));
  }

  Future<void> _onDeleteIncome(
    DeleteIncomeEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await incomeRepository.deleteIncome(event.incomeId);
    final result = await incomeRepository.getBudgetIncome(budgetId);
    emit(state.copyWith(income: () => result));
  }

  Future<void> _onDeleteExpense(
    DeleteExpenseEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await expenseRepository.deleteExpense(event.expenseId);
    final result = await expenseRepository.getExpensesByBudgetId(budgetId);
    int totalSpent = 0;
    for (Expense expense in result) {
      totalSpent += expense.amount;
    }

    emit(state.copyWith(
      expenses: () => result,
      totalSpent: () => totalSpent,
    ));
  }

  Future<void> _onDeleteCategory(
    DeleteCategoryEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await categoryRepository.deleteCategory(event.categoryId);
    final result = await categoryRepository.getCategoriesByBudgetId(budgetId);
    emit(state.copyWith(categories: () => result));
  }
}
