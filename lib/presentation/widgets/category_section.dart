import 'package:budgeting_app/data/repositories/category_repository_impl.dart';
import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/presentation/widgets/category_header.dart';
import 'package:budgeting_app/presentation/widgets/category_list.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatefulWidget {
  final int budgetId;
  const CategorySection({
    super.key,
    required this.budgetId,
  });

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  bool _showList = true;
  CategoryRepositoryImpl categoryRepository = CategoryRepositoryImpl();

  void _toggleList() {
    setState(() {
      _showList = !_showList;
    });
  }

  void _addCategory(Category category) {
    categoryRepository.insertCategory(category.copy(budgetId: widget.budgetId));
    setState(() {});
  }

  void _deleteCategory(int categoryId) {
    categoryRepository.deleteCategory(categoryId);
    setState(() {});
  }

  void _updateCategory(Category newCategory) {
    categoryRepository.updateCategory(newCategory);
    setState(() {});
  }

  Future<int> _getTotal(int categoryId) {
    return categoryRepository.getTotalSpent(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CateggoryHeader(
          showingList: _showList,
          onToggle: _toggleList,
          onAdd: _addCategory,
        ),
        if (_showList)
          FutureBuilder(
            future: categoryRepository.getCategoriesByBudgetId(widget.budgetId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CategoryList(
                  categories: snapshot.data!,
                  deleteItem: _deleteCategory,
                  updateItem: _updateCategory,
                  getItemTotal: _getTotal,
                );
              }
              return Container();
            },
          ),
      ],
    );
  }
}
