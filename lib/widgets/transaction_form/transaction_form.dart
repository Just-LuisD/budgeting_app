import 'package:budgeting_app/data/transaction_database.dart';
import 'package:budgeting_app/models/transaction.dart';
import 'package:budgeting_app/widgets/transaction_form/amount_field.dart';
import 'package:budgeting_app/widgets/transaction_form/category_field.dart';
import 'package:budgeting_app/widgets/transaction_form/title_field.dart';
import 'package:budgeting_app/widgets/transaction_form/type_toggle.dart';
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
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const TypeToggle(),
          TitleField(inputController: transactionTitleController),
          CategoryField(inputController: transactionCategoryController),
          AmountField(inputController: transactionAmountController),
          Row(
            children: [
              Text('Date: ${DateFormat.yMMMd().format(transactionDate)}'),
              IconButton(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_month),
              )
            ],
          ),
          TextFormField(
            maxLines: 8,
            decoration: const InputDecoration(
              label: Text("Notes"),
            ),
          ),
          ElevatedButton(
            onPressed: widget.transaction == null
                ? _submitTransaction
                : _updateTransaction,
            child: Text(widget.transaction == null
                ? 'Add Transaction'
                : "Update Transaction"),
          ),
        ]
            .map((child) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 4,
                  ),
                  child: child,
                ))
            .toList(),
      ),
    );
  }
}
