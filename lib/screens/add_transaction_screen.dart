import 'package:budgeting_app/widgets/transaction_form.dart';
import 'package:flutter/material.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TransactionForm(),
    );
  }
}
