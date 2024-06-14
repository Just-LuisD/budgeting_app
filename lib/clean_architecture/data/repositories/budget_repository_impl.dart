import 'package:budgeting_app/clean_architecture/domain/entities/budget.dart';
import 'package:budgeting_app/clean_architecture/domain/repositories/budget_repository.dart';
import 'package:budgeting_app/clean_architecture/data/local_database.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Future<List<Budget>> getAllBudgets() async {
    final db = await dbHelper.database;
    final maps = await db.query('Budgets');
    return List.generate(maps.length, (i) {
      return Budget.fromMap(maps[i]);
    });
  }

  @override
  Future<Budget> getBudgetById(int id) async {
    final db = await dbHelper.database;
    final maps = await db.query('Budgets', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Budget.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  @override
  Future<int> insertBudget(Budget budget) async {
    final db = await dbHelper.database;
    return await db.insert('Budgets', budget.toMap());
  }

  @override
  Future<int> updateBudget(Budget budget) async {
    final db = await dbHelper.database;
    return await db.update('Budgets', budget.toMap(),
        where: 'id = ?', whereArgs: [budget.id]);
  }

  @override
  Future<int> deleteBudget(int id) async {
    final db = await dbHelper.database;
    return await db.delete('Budgets', where: 'id = ?', whereArgs: [id]);
  }
}
