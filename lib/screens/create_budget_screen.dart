import 'package:budgeting_app/widgets/budget_form/budget_form.dart';
import 'package:flutter/material.dart';

class CreateBudgetScreen extends StatelessWidget {
  const CreateBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Your Budget"),
      ),
      body: BudgetForm(),
    );
  }
}
