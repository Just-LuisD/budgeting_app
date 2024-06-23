import 'package:budgeting_app/clean_architecture/domain/entities/budget.dart';
import 'package:budgeting_app/clean_architecture/domain/entities/category.dart';
import 'package:budgeting_app/clean_architecture/domain/repositories/budget_repository.dart';
import 'package:budgeting_app/clean_architecture/data/local_database.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Future<List<Budget>> getAllBudgets() async {
    final maps = await dbHelper.getBudgets();
    List<Budget> budgets = [];
    for (int i = 0; i < maps.length; i++) {
      var budget = Budget.fromMap(maps[i]);
      final categoryMaps = await dbHelper.getCategories(budget.id!);
      List<Category> categories = [];
      for (final cat in categoryMaps) {
        categories.add(Category.fromMap(cat));
      }
      budget = budget.copy(categories: categories);
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
    for (int i = 0; i < budget.categories!.length; i++) {
      await dbHelper.insertCategory(
          budget.categories![i].copy(budgetId: budgetId).toMap());
    }
    return budgetId;
  }

  @override
  Future<int> updateBudget(Budget budget) async {
    final numChanged = await dbHelper.updateBudget(budget.toMap());
    dbHelper.deleteCategoryByBudgetId(budget.id!);
    for (int i = 0; i < budget.categories!.length; i++) {
      await dbHelper.insertCategory(
        budget.categories![i].copy(budgetId: budget.id).toMap(),
      );
    }
    return numChanged;
  }

  @override
  Future<int> deleteBudget(int id) async {
    return await dbHelper.deleteBudget(id);
  }
}
