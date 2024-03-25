import 'package:budgeting_app/widgets/budget_form/budget_form.dart';
import 'package:flutter/material.dart';

class CreateBudgetScreen extends StatelessWidget {
  final String template;
  const CreateBudgetScreen({
    super.key,
    required this.template,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(template),
      ),
      body: const BudgetForm(),
    );
  }
}
