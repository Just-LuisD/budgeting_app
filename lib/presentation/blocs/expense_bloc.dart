import 'package:budgeting_app/data/repositories/expense_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepositoryImpl expenseRepository;

  ExpenseBloc(this.expenseRepository) : super(ExpenseInitial()) {
    on<FetchExpenses>(_onFetchExpenses);
    on<AddExpense>(_onAddExpense);
    on<UpdateExpense>(_onUpdateExpense);
    on<DeleteExpense>(_onDeleteExpense);
  }

  Future<void> _onFetchExpenses(
    FetchExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoading());
    try {
      final expenses =
          await expenseRepository.getExpensesByBudgetId(event.budgetId);
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> _onAddExpense(
      AddExpense event, Emitter<ExpenseState> emit) async {
    await expenseRepository.insertExpense(event.expense);
    add(FetchExpenses(event.expense.budgetId!));
  }

  Future<void> _onUpdateExpense(
    UpdateExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    await expenseRepository.updateExpense(event.expense);
    add(FetchExpenses(event.expense.budgetId!));
  }

  Future<void> _onDeleteExpense(
    DeleteExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    await expenseRepository.deleteExpense(event.expense.id!);
    add(FetchExpenses(event.expense.budgetId!));
  }
}
