import '../entities/budget.dart';

abstract class BudgetRepository {
  Future<List<Budget>> getAllBudgets();
  Future<Budget> getBudgetById(int id);
  Future<int> insertBudget(Budget budget);
  Future<int> updateBudget(Budget budget);
  Future<int> deleteBudget(int id);
}
