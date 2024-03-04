import 'package:budgeting_app/models/budget.dart';
import 'package:budgeting_app/widgets/budget_creation/start_budget.dart';
import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  List<BudgetTemplate> budgetTemplates = [];
  late Widget content;

  @override
  Widget build(BuildContext context) {
    if (budgetTemplates.isEmpty) {
      content = const StartBudget();
    }
    return content;
  }
}
