import 'package:budgeting_app/widgets/budget_form/category_input_field.dart';
import 'package:flutter/material.dart';

class AddBudgetItemScreen extends StatelessWidget {
  const AddBudgetItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Budget Item"),
        actions: [IconButton(onPressed: () => {}, icon: Icon(Icons.delete))],
      ),
      body: const CategoryInputField(),
    );
  }
}
