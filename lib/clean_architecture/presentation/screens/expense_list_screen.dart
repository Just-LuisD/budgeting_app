import 'package:budgeting_app/database/transaction_database.dart';
import 'package:budgeting_app/models/transaction.dart';
import 'package:budgeting_app/screens/add_transaction_screen.dart';
import 'package:budgeting_app/screens/edit_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({
    super.key,
  });

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  late List<FinancialTransaction> transactions = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshTransactions();
  }

  @override
  void dispose() {
    TransactionDatabase.instance.close();
    super.dispose();
  }

  Future refreshTransactions() async {
    setState(() {
      isLoading = true;
    });

    transactions = await TransactionDatabase.instance.readAllTransactions();

    setState(() {
      isLoading = false;
    });
  }

  void _addNewTransaction() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTransactionScreen()),
    ).then((value) => refreshTransactions());
  }

  void _editTransaction(FinancialTransaction tappedTransaction) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => EditTransactionScreen(
                  transaction: tappedTransaction,
                )))
        .then((value) => refreshTransactions());
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
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  bool addDate = false;
                  lastDate ??= transactions[index].date;
                  if (!DateUtils.isSameDay(
                      lastDate, transactions[index].date)) {
                    addDate = true;
                    lastDate = transactions[index].date;
                    total = 0;
                  }
                  total += transactions[index].amount;
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
                              child: Text(DateFormat.yMMMd().format(lastDate!)),
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
                          _editTransaction(transactions[index]);
                        },
                        child: Card(
                          child: ListTile(
                            leading: Text(transactions[index].category),
                            title: Text(transactions[index].title),
                            trailing: Text("\$${transactions[index].amount}"),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: _addNewTransaction,
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
