import 'package:budgeting_app/clean_architecture/domain/entities/expense.dart';
import 'package:budgeting_app/clean_architecture/domain/repositories/expense_repository.dart';
import 'package:budgeting_app/clean_architecture/data/local_database.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Future<List<Expense>> getExpensesByBudgetId(int budgetId) async {
    final maps = await dbHelper.getExpensesByBudgetId(budgetId);
    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  @override
  Future<List<Expense>> getExpensesByCategoryId(int categoryId) async {
    final db = await dbHelper.database;
    final maps = await db
        .query('Expenses', where: 'category_id = ?', whereArgs: [categoryId]);
    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  @override
  Future<Expense> getExpenseById(int id) async {
    final db = await dbHelper.database;
    final maps = await db.query('Expenses', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Expense.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  @override
  Future<int> insertExpense(Expense expense) async {
    final db = await dbHelper.database;
    final response = await db.insert('Expenses', expense.toMap());
    return response;
  }

  @override
  Future<int> updateExpense(Expense expense) async {
    final db = await dbHelper.database;
    final response = await db.update(
      'Expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
    return response;
  }

  @override
  Future<int> deleteExpense(int id) async {
    final db = await dbHelper.database;
    final response = await db.delete(
      'Expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
    return response;
  }
}
