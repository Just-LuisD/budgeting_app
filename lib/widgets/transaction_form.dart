import 'package:budgeting_app/data/transaction_database.dart';
import 'package:budgeting_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final FinancialTransaction? transaction;
  const TransactionForm({super.key, this.transaction});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController transactionTitleController = TextEditingController();
  TextEditingController transactionCategoryController = TextEditingController();
  TextEditingController transactionAmountController = TextEditingController();
  DateTime transactionDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.transaction != null) {
      transactionTitleController.text = widget.transaction!.title;
      transactionCategoryController.text = widget.transaction!.category;
      transactionAmountController.text = widget.transaction!.amount.toString();
      transactionDate = widget.transaction!.date!;
    }
  }

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

  void _updateTransaction() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    widget.transaction!.title = transactionTitleController.text;
    widget.transaction!.category = transactionCategoryController.text;
    widget.transaction!.amount = double.parse(transactionAmountController.text);
    widget.transaction!.date = transactionDate;
    TransactionDatabase.instance.update(widget.transaction!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
            onPressed: widget.transaction == null
                ? _submitTransaction
                : _updateTransaction,
            child: Text(widget.transaction == null
                ? 'Add Transaction'
                : "Update Transaction"),
          ),
        ],
      ),
    );
  }
}
