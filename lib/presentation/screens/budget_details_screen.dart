import 'package:budgeting_app/data/repositories/budget_repository_impl.dart';
import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:budgeting_app/presentation/widgets/budget_modal.dart';
import 'package:budgeting_app/presentation/widgets/category_section.dart';
import 'package:budgeting_app/presentation/widgets/expense_section.dart';
import 'package:budgeting_app/presentation/widgets/income_section.dart';
import 'package:flutter/material.dart';

class BudgetDetailsScreen extends StatefulWidget {
  final Budget budget;
  const BudgetDetailsScreen({super.key, required this.budget});

  @override
  State<BudgetDetailsScreen> createState() => _BudgetFormScreemState();
}

class _BudgetFormScreemState extends State<BudgetDetailsScreen> {
  BudgetRepositoryImpl budgetRepository = BudgetRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.budget.name,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return BudgetModal(
                    budget: widget.budget,
                    onSubmit: budgetRepository.updateBudget,
                  );
                },
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Expected Income: \$${widget.budget.income}"),
              IncomeSection(
                budgetId: widget.budget.id!,
              ),
              CategorySection(
                budgetId: widget.budget.id!,
              ),
              ExpenseSection(),
            ],
          ),
        ),
      ),
    );
  }
}
