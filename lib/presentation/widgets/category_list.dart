import 'package:budgeting_app/domain/entities/category.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  const CategoryList({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, idx) {
          return CategoryItem(category: categories[idx]);
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.name),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.delete),
      ),
    );
  }
}
