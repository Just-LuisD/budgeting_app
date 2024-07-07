import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/repositories/category_repository.dart';
import 'package:budgeting_app/data/local_database.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Future<List<Category>> getCategoriesByBudgetId(int budgetId) async {
    final maps = await dbHelper.getCategories(budgetId);
    return List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });
  }

  @override
  Future<Category> getCategoryById(int id) async {
    final map = await dbHelper.getCategory(id);
    return Category.fromMap(map);
  }

  @override
  Future<int> insertCategory(Category category) async {
    return await dbHelper.insertCategory(category.toMap());
  }

  @override
  Future<int> updateCategory(Category category) async {
    return await dbHelper.updateCategory(category.toMap());
  }

  @override
  Future<int> deleteCategory(int id) async {
    return await dbHelper.deleteCategory(id);
  }
}
