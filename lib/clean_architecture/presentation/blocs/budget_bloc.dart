import 'package:budgeting_app/clean_architecture/data/repositories/budget_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'budget_event.dart';
import 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final BudgetRepositoryImpl budgetRepository;

  BudgetBloc(this.budgetRepository) : super(BudgetInitial()) {
    on<FetchBudgets>(_onFetchBudgets);
    on<AddBudget>(_onAddBudget);
    on<UpdateBudget>(_onUpdateBudget);
    on<DeleteBudget>(_onDeleteBudget);
  }

  Future<void> _onFetchBudgets(
    FetchBudgets event,
    Emitter<BudgetState> emit,
  ) async {
    emit(BudgetLoading());
    try {
      final budgets = await budgetRepository.getAllBudgets();
      emit(BudgetLoaded(budgets));
    } catch (e) {
      emit(BudgetError(e.toString()));
    }
  }

  Future<void> _onAddBudget(AddBudget event, Emitter<BudgetState> emit) async {
    await budgetRepository.insertBudget(event.budget);
    add(FetchBudgets());
  }

  Future<void> _onUpdateBudget(
    UpdateBudget event,
    Emitter<BudgetState> emit,
  ) async {
    await budgetRepository.updateBudget(event.budget);
    add(FetchBudgets());
  }

  Future<void> _onDeleteBudget(
    DeleteBudget event,
    Emitter<BudgetState> emit,
  ) async {
    await budgetRepository.deleteBudget(event.id);
    add(FetchBudgets());
  }
}
