import 'package:flutter/material.dart';

class CategoryField extends StatelessWidget {
  final TextEditingController inputController;
  const CategoryField({
    super.key,
    required this.inputController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      decoration: const InputDecoration(
        labelText: 'Category',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Your transaction must have a category.';
        }
        return null;
      },
    );
  }
}
