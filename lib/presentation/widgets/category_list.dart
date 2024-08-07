import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/presentation/widgets/category_form.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final void Function(int) deleteItem;
  final void Function(Category) updateItem;

  const CategoryList({
    super.key,
    required this.categories,
    required this.deleteItem,
    required this.updateItem,
  });

  @override
  Widget build(BuildContext context) {
    return categories.isEmpty
        ? const Text("No Categories Found")
        : Flexible(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, idx) {
                return CategoryItem(
                  category: categories[idx],
                  onDelete: deleteItem,
                  onUpdate: updateItem,
                );
              },
            ),
          );
  }
}

class CategoryItem extends StatelessWidget {
  final Category category;
  final void Function(int) onDelete;
  final void Function(Category) onUpdate;

  const CategoryItem({
    super.key,
    required this.category,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.name),
      trailing: IconButton(
        onPressed: () {
          onDelete(category.id!);
        },
        icon: const Icon(Icons.delete),
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
              ),
            );
          },
        );
      },
    );
  }
}
