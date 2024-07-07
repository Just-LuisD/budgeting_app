import '../entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategoriesByBudgetId(int budgetId);
  Future<Category> getCategoryById(int id);
  Future<int> insertCategory(Category category);
  Future<int> updateCategory(Category category);
  Future<int> deleteCategory(int id);
}
