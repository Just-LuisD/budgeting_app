import 'package:budgeting_app/data/transaction_database.dart';
import 'package:budgeting_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController transactionTitleController = TextEditingController();
  TextEditingController transactionCategoryController = TextEditingController();
  TextEditingController transactionAmountController = TextEditingController();
  DateTime transactionDate = DateTime.now();

  void _pickDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (selectedDate != null) {
      setState(() {
        transactionDate = selectedDate;
      });
    }
  }

  void _submitTransaction() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    await TransactionDatabase.instance
        .create(
          FinancialTransaction(
            title: transactionTitleController.text,
            category: transactionCategoryController.text,
            amount: double.parse(transactionAmountController.text),
            date: transactionDate,
          ),
        )
        .then((value) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 10,
            right: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: transactionTitleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Your transaction must have a title.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: transactionCategoryController,
                decoration: const InputDecoration(
                  labelText: 'Category',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Your transaction must have a category.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: transactionAmountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: '\$',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null ||
                      double.tryParse(value)! <= 0) {
                    return 'Your transaction amount must be a positive value.';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Text('Date: ${DateFormat.yMMMd().format(transactionDate)}'),
                  IconButton(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_month),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: _submitTransaction,
                child: const Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
