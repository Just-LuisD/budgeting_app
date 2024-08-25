import 'package:bloc/bloc.dart';
import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:budgeting_app/domain/repositories/budget_repository.dart';
import 'package:budgeting_app/domain/repositories/category_repository.dart';
import 'package:budgeting_app/domain/repositories/expense_repository.dart';
import 'package:budgeting_app/domain/repositories/income_repository.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_state.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_event.dart';

class BudgetDetailsBloc extends Bloc<BudgetDetailsEvent, BudgetDetailsState> {
  final Budget budget;
  final BudgetRepository budgetRepository;
  final IncomeRepository incomeRepository;
  final ExpenseRepository expenseRepository;
  final CategoryRepository categoryRepository;

  BudgetDetailsBloc({
    required this.budget,
    required this.budgetRepository,
    required this.categoryRepository,
    required this.expenseRepository,
    required this.incomeRepository,
  }) : super(BudgetDetailsState(budget: budget)) {
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
    await incomeRepository.insertIncome(event.newIncome);
    final result = await incomeRepository.getBudgetIncome(budget.id!);
    emit(state.copyWith(income: () => result));
  }

  Future<void> _onAddExpense(
    AddExpenseEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await expenseRepository.insertExpense(event.newExpense);
    final result = await expenseRepository.getExpensesByBudgetId(budget.id!);
    emit(state.copyWith(expenses: () => result));
  }

  Future<void> _onAddCategory(
    AddCategoryEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await categoryRepository.insertCategory(event.newCategory);
    final result = await categoryRepository.getCategoriesByBudgetId(budget.id!);
    emit(state.copyWith(categories: () => result));
  }

  Future<void> _onUpdateIncome(
    UpdateIncomeEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await incomeRepository.updateIncome(event.updatedIncome);
    final result = await incomeRepository.getBudgetIncome(budget.id!);
    emit(state.copyWith(income: () => result));
  }

  Future<void> _onUpdateExpense(
    UpdateExpenseEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await expenseRepository.updateExpense(event.updatedExpense);
    final result = await expenseRepository.getExpensesByBudgetId(budget.id!);
    emit(state.copyWith(expenses: () => result));
  }

  Future<void> _onUpdateCategory(
    UpdateCategoryEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await categoryRepository.updateCategory(event.updatedCategory);
    final result = await categoryRepository.getCategoriesByBudgetId(budget.id!);
    emit(state.copyWith(categories: () => result));
  }

  Future<void> _onDeleteIncome(
    DeleteIncomeEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await incomeRepository.deleteIncome(event.incomeId);
    final result = await incomeRepository.getBudgetIncome(budget.id!);
    emit(state.copyWith(income: () => result));
  }

  Future<void> _onDeleteExpense(
    DeleteExpenseEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await expenseRepository.deleteExpense(event.expenseId);
    final result = await expenseRepository.getExpensesByBudgetId(budget.id!);
    emit(state.copyWith(expenses: () => result));
  }

  Future<void> _onDeleteCategory(
    DeleteCategoryEvent event,
    Emitter<BudgetDetailsState> emit,
  ) async {
    await categoryRepository.deleteCategory(event.categoryId);
    final result = await categoryRepository.getCategoriesByBudgetId(budget.id!);
    emit(state.copyWith(categories: () => result));
  }
}
