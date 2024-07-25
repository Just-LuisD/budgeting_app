import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:budgeting_app/domain/entities/income.dart';
import 'package:budgeting_app/presentation/screens/expense_form_screen.dart';
import 'package:budgeting_app/presentation/widgets/budget_modal.dart';
import 'package:budgeting_app/presentation/widgets/income_header.dart';
import 'package:flutter/material.dart';

class BudgetDetailsScreen extends StatefulWidget {
  final Budget budget;
  const BudgetDetailsScreen({super.key, required this.budget});

  @override
  State<BudgetDetailsScreen> createState() => _BudgetFormScreemState();
}

class _BudgetFormScreemState extends State<BudgetDetailsScreen> {
  bool _showCategories = true;
  bool _showExpenses = true;

  void submitIncome(Income income) {
    // TODO: submit income
  }

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
                  return BudgetModal(budget: widget.budget);
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
            children: [
              Text("Expected Income: \$${widget.budget.income}"),
              const SizedBox(height: 20),
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      IncomeHeader(onSubmit: submitIncome),
                      ListView.builder(
                        itemCount: [].length,
                        itemBuilder: (context, index) {
                          return ListTile();
                        },
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _showCategories = !_showCategories;
                              });
                            },
                            icon: Icon(_showCategories
                                ? Icons.arrow_drop_down
                                : Icons.arrow_right_outlined),
                          ),
                          Expanded(
                            child: Text("Categories"),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Scaffold(
                                    appBar: AppBar(
                                      title: Text("Add Category"),
                                    ),
                                    body: SingleChildScrollView(
                                      child: Form(
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: null,
                                              decoration: const InputDecoration(
                                                labelText: 'Name',
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Your transaction must have a title.';
                                                }
                                                return null;
                                              },
                                            ),
                                            TextFormField(
                                              controller: null,
                                              decoration: InputDecoration(
                                                labelText: "Limit",
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty ||
                                                    double.tryParse(value) ==
                                                        null ||
                                                    double.tryParse(value)! <=
                                                        0) {
                                                  return 'Your transaction amount must be a positive value.';
                                                }
                                                return null;
                                              },
                                            ),
                                            ElevatedButton(
                                              onPressed: () {},
                                              child: Text("Add"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _showExpenses = !_showExpenses;
                              });
                            },
                            icon: Icon(_showExpenses
                                ? Icons.arrow_drop_down
                                : Icons.arrow_right_outlined),
                          ),
                          Expanded(
                            child: Text("Expenses"),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => ExpenseFormScreen(
                                  budgetId: widget.budget.id!,
                                  categories: [],
                                ),
                              );
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
