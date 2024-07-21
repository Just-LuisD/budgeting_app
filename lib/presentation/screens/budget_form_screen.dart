import 'package:budgeting_app/data/repositories/expense_repository_impl.dart';
import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:budgeting_app/presentation/blocs/expense_bloc.dart';
import 'package:budgeting_app/presentation/screens/expense_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BudgetFormScreen extends StatefulWidget {
  final Budget budget;
  const BudgetFormScreen({super.key, required this.budget});

  @override
  State<BudgetFormScreen> createState() => _BudgetFormScreemState();
}

class _BudgetFormScreemState extends State<BudgetFormScreen> {
  bool _showCategories = true;
  bool _showExpenses = true;
  var _expenseDate = DateTime.now();

  void _pickDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _expenseDate,
      firstDate: DateTime(_expenseDate.year, _expenseDate.month, 1),
      lastDate: DateTime(_expenseDate.year, _expenseDate.month + 1, 1).subtract(
        Duration(days: 1),
      ),
    );

    if (selectedDate != null) {
      setState(() {
        _expenseDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.budget.name,
        ),
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
                            child: Text("Income"),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Scaffold(
                                    appBar: AppBar(
                                      title: Text("Add Income"),
                                    ),
                                    body: SingleChildScrollView(
                                      child: Form(
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: null,
                                              decoration: const InputDecoration(
                                                labelText: 'Title',
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
                                                labelText: "Amount",
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
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'Date: ${DateFormat.yMMMd().format(_expenseDate)}',
                                                  ),
                                                ),
                                                IconButton(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  onPressed: _pickDate,
                                                  icon: Icon(
                                                      Icons.calendar_month),
                                                ),
                                              ],
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
                                builder: (context) => BlocProvider(
                                  create: (context) =>
                                      ExpenseBloc(ExpenseRepositoryImpl()),
                                  child: ExpenseFormScreen(
                                    budgetId: widget.budget!.id!,
                                    categories: [],
                                  ),
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
