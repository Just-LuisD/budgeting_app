import 'package:budgeting_app/presentation/widgets/category_header.dart';
import 'package:budgeting_app/presentation/widgets/category_list.dart';
import 'package:budgeting_app/test_data.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  bool _showList = true;

  void _toggleList() {
    setState(() {
      _showList = !_showList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CateggoryHeader(
            showingList: _showList,
            onToggle: _toggleList,
          ),
          if (_showList) CategoryList(categories: testCategories1)
        ],
      ),
    );
  }
}
