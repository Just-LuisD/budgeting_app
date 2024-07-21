import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:budgeting_app/domain/repositories/budget_repository.dart';
import 'package:budgeting_app/data/local_database.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Future<List<Budget>> getAllBudgets() async {
    final maps = await dbHelper.getBudgets();
    List<Budget> budgets = [];
    for (int i = 0; i < maps.length; i++) {
      var budget = Budget.fromMap(maps[i]);
      budgets.add(budget);
    }
    return budgets;
  }

  @override
  Future<Budget> getBudgetById(int id) async {
    final map = await dbHelper.getBudget(id);
    return Budget.fromMap(map);
  }

  @override
  Future<int> insertBudget(Budget budget) async {
    final budgetId = await dbHelper.insertBudget(budget.toMap());
    return budgetId;
  }

  @override
  Future<int> updateBudget(Budget budget) async {
    return await dbHelper.updateBudget(budget.toMap());
  }

  @override
  Future<int> deleteBudget(int id) async {
    return await dbHelper.deleteBudget(id);
  }
}
