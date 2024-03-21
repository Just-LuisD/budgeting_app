import 'package:budgeting_app/models/category.dart';
import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final Category category;

  const CategoryIcon({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 70,
        height: 70,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.amber,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              category.image,
            ),
          ),
        ),
      ),
    );
  }
}
