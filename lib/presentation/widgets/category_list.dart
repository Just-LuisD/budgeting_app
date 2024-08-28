import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/presentation/widgets/category_form.dart';
import 'package:budgeting_app/presentation/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final void Function(int) deleteItem;
  final void Function(Category) updateItem;
  final int Function(int) getItemTotal;

  const CategoryList({
    super.key,
    required this.categories,
    required this.deleteItem,
    required this.updateItem,
    required this.getItemTotal,
  });

  @override
  Widget build(BuildContext context) {
    return categories.isEmpty
        ? const Center(child: Text("No Categories Found"))
        : ListView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, idx) {
              int total = getItemTotal(categories[idx].id!);
              return CategoryItem(
                category: categories[idx],
                categoryTotal: total,
                onDelete: deleteItem,
                onUpdate: updateItem,
              );
            },
          );
  }
}

class CategoryItem extends StatelessWidget {
  final Category category;
  final int categoryTotal;
  final void Function(int) onDelete;
  final void Function(Category) onUpdate;

  const CategoryItem({
    super.key,
    required this.category,
    required this.categoryTotal,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category.name,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            ProgressBar(
              minVal: 0,
              maxVal: category.spendingLimit,
              value: categoryTotal,
              height: 12,
              color: Colors.red,
            ),
          ],
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: CategoryForm(
                category: category,
                onSubmit: onUpdate,
                onDelete: onDelete,
              ),
            );
          },
        );
      },
    );
  }
}
