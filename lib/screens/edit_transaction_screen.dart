import 'package:budgeting_app/data/transaction_database.dart';
import 'package:budgeting_app/models/transaction.dart';
import 'package:budgeting_app/widgets/transaction_form/transaction_form.dart';
import 'package:flutter/material.dart';

class EditTransactionScreen extends StatelessWidget {
  final FinancialTransaction transaction;
  const EditTransactionScreen({
    super.key,
    required this.transaction,
  });

  void _deleteTransaction(BuildContext ctx) {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete Transaction"),
            content: const Text(
                "Are you sure you want to permanentely delete this transaction?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await TransactionDatabase.instance.delete(transaction.id!);
                  Navigator.popUntil(context, ModalRoute.withName('/home'));
                },
                child: const Text("Yes"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Transaction'),
        actions: [
          IconButton(
            onPressed: () => {_deleteTransaction(context)},
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: TransactionForm(
        transaction: transaction,
      ),
    );
  }
}
