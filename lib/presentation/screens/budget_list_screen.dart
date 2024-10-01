import 'package:budgeting_app/data/repositories/budget_repository_impl.dart';
import 'package:budgeting_app/data/repositories/category_repository_impl.dart';
import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/presentation/widgets/budget_card.dart';
import 'package:budgeting_app/presentation/widgets/budget_modal.dart';
import 'package:flutter/material.dart';

class BudgetListScreen extends StatefulWidget {
  const BudgetListScreen({super.key});

  @override
  State<BudgetListScreen> createState() => _BudgetListScreenState();
}

class _BudgetListScreenState extends State<BudgetListScreen> {
  BudgetRepositoryImpl budgetRepository = BudgetRepositoryImpl();
  CategoryRepositoryImpl categoryRepository = CategoryRepositoryImpl();

  void copyBudget(Budget templateBudget) async {
    Budget newBudget = Budget(
      name: "${templateBudget.name}(Copy)",
      income: templateBudget.income,
    );
    int budgetId = await budgetRepository.insertBudget(newBudget);
    List<Category> templateCategories =
        await categoryRepository.getCategoriesByBudgetId(templateBudget.id!);
    for (Category category in templateCategories) {
      Category copyCategory = Category(
          name: category.name,
          spendingLimit: category.spendingLimit,
          budgetId: budgetId);
      categoryRepository.insertCategory(copyCategory);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgets'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: budgetRepository.getAllBudgets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var budgets = snapshot.data!;
            return budgets.isEmpty
                ? const Center(child: Text('No Budgets Available'))
                : ListView.builder(
                    itemCount: budgets.length,
                    itemBuilder: (context, index) {
                      final budget = budgets[index];
                      return BudgetCard(
                        key: UniqueKey(),
                        budget: budget,
                        onDelete: () {
                          budgetRepository.deleteBudget(budget.id!);
                          setState(() {});
                        },
                        onCopy: () {
                          copyBudget(budget);
                        },
                      );
                    },
                  );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return BudgetModal(
                onSubmit: budgetRepository.insertBudget,
              );
            },
          ).then((value) {
            if (value == true) {
              setState(() {});
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
