import 'package:budgeting_app/clean_architecture/data/repositories/expense_repository_impl.dart';
import 'package:budgeting_app/clean_architecture/domain/entities/expense.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/expense_bloc.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/expense_event.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/expense_state.dart';
import 'package:budgeting_app/clean_architecture/presentation/screens/expense_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({
    super.key,
  });

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  bool isLoading = false;

  void _addNewTransaction(Expense? expense) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => ExpenseBloc(ExpenseRepositoryImpl()),
          child: ExpenseFormScreen(
            expense: expense,
          ),
        ),
      ),
    ).then((result) {
      if (result == true) {
        context.read<ExpenseBloc>().add(FetchExpenses(1));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime? lastDate;
    double total = 0;
    return PageView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Text(
              DateFormat.MMMM().format(DateTime.now()),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            Expanded(
              child: BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (context, state) {
                  if (state is ExpenseLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ExpenseLoaded) {
                    final expenses = state.expenses;
                    return expenses.isEmpty
                        ? const Center(child: Text('No expenses available'))
                        : ListView.builder(
                            itemCount: expenses.length,
                            itemBuilder: (BuildContext context, int index) {
                              bool addDate = false;
                              lastDate ??=
                                  DateTime.tryParse(expenses[index].date);
                              if (!DateUtils.isSameDay(lastDate,
                                  DateTime.tryParse(expenses[index].date))) {
                                addDate = true;
                                lastDate =
                                    DateTime.tryParse(expenses[index].date);
                                total = 0;
                              }
                              total += expenses[index].amount;
                              return Column(
                                children: [
                                  if (addDate)
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3,
                                            horizontal: 6,
                                          ),
                                          child: Text(DateFormat.yMMMd()
                                              .format(lastDate!)),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3,
                                            horizontal: 6,
                                          ),
                                          child: Text(
                                            total.toString(),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                  GestureDetector(
                                    onTap: () {
                                      _addNewTransaction(expenses[index]);
                                    },
                                    child: Card(
                                      child: ListTile(
                                        leading: Text(expenses[index]
                                            .categoryId
                                            .toString()),
                                        title: Text(expenses[index].title),
                                        trailing:
                                            Text("\$${expenses[index].amount}"),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                  } else if (state is ExpenseError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    _addNewTransaction(null);
                  },
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        );
      },
    );
  }
}
