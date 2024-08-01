import 'package:budgeting_app/domain/entities/category.dart';
import 'package:flutter/material.dart';

class CategoryForm extends StatefulWidget {
  final Category? category;
  final void Function(Category) onSubmit;

  const CategoryForm({
    super.key,
    required this.onSubmit,
    this.category,
  });

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _limitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _nameController.text = widget.category!.name;
      _limitController.text = widget.category!.spendingLimit.toString();
    }
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final name = _nameController.text;
    final limit = double.tryParse(_limitController.text);

    Category newCategory;

    if (widget.category == null) {
      newCategory = Category(name: name, spendingLimit: limit!);
    } else {
      newCategory = widget.category!.copy(name: name, spendingLimit: limit!);
    }

    widget.onSubmit(newCategory);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add Category",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Your transaction must have a title.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _limitController,
              decoration: const InputDecoration(
                labelText: "Limit",
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    double.tryParse(value) == null ||
                    double.tryParse(value)! <= 0) {
                  return 'Your transaction amount must be a positive value.';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: _onSubmit,
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
