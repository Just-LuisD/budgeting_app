import 'package:budgeting_app/clean_architecture/domain/entities/budget.dart';
import 'package:budgeting_app/clean_architecture/domain/repositories/budget_repository.dart';
import 'package:budgeting_app/clean_architecture/data/local_database.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Future<List<Budget>> getAllBudgets() async {
    final maps = await dbHelper.getBudgets();
    return List.generate(maps.length, (i) {
      return Budget.fromMap(maps[i]);
    });
  }

  @override
  Future<Budget> getBudgetById(int id) async {
    final map = await dbHelper.getBudget(id);
    return Budget.fromMap(map);
  }

  @override
  Future<int> insertBudget(Budget budget) async {
    return await dbHelper.insertBudget(budget.toMap());
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
