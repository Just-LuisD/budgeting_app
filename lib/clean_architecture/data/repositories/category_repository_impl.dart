import 'package:budgeting_app/clean_architecture/domain/entities/category.dart';
import 'package:budgeting_app/clean_architecture/domain/repositories/category_repository.dart';
import 'package:budgeting_app/clean_architecture/data/local_database.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Future<List<Category>> getCategoriesByBudgetId(int budgetId) async {
    final db = await dbHelper.database;
    final maps = await db
        .query('Categories', where: 'budget_id = ?', whereArgs: [budgetId]);
    return List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });
  }

  @override
  Future<Category> getCategoryById(int id) async {
    final db = await dbHelper.database;
    final maps = await db.query('Categories', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Category.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  @override
  Future<int> insertCategory(Category category) async {
    final db = await dbHelper.database;
    return await db.insert('Categories', category.toMap());
  }

  @override
  Future<int> updateCategory(Category category) async {
    final db = await dbHelper.database;
    return await db.update('Categories', category.toMap(),
        where: 'id = ?', whereArgs: [category.id]);
  }

  @override
  Future<int> deleteCategory(int id) async {
    final db = await dbHelper.database;
    return await db.delete('Categories', where: 'id = ?', whereArgs: [id]);
  }
}
