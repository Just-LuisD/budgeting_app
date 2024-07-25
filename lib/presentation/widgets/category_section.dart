import 'package:budgeting_app/presentation/widgets/category_header.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CateggoryHeader(),
        ],
      ),
    );
  }
}
