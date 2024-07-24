import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:budgeting_app/presentation/widgets/budget_card.dart';
import 'package:budgeting_app/presentation/widgets/budget_modal.dart';
import 'package:flutter/material.dart';

class BudgetListScreen extends StatelessWidget {
  final List<Budget> budgets;
  const BudgetListScreen({super.key, required this.budgets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgets'),
        centerTitle: true,
      ),
      body: budgets.isEmpty
          ? const Center(child: Text('No budgets available'))
          : ListView.builder(
              itemCount: budgets.length,
              itemBuilder: (context, index) {
                final budget = budgets[index];
                return BudgetCard(
                  key: UniqueKey(),
                  budget: budget,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return const BudgetModal();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
