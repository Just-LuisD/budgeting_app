import 'package:budgeting_app/widgets/transaction_form/transaction_form.dart';
import 'package:flutter/material.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transaction"),
      ),
      body: const TransactionForm(),
    );
  }
}
