import 'package:budgeting_app/database/transaction_database.dart';
import 'package:budgeting_app/models/transaction.dart';
import 'package:budgeting_app/widgets/transaction_form/amount_field.dart';
import 'package:budgeting_app/widgets/transaction_form/category_field.dart';
import 'package:budgeting_app/widgets/transaction_form/notes_field.dart';
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
  TransactionType transactionType = TransactionType.expense;
  TextEditingController transactionTitleController = TextEditingController();
  TextEditingController transactionCategoryController = TextEditingController();
  TextEditingController transactionAmountController = TextEditingController();
  DateTime transactionDate = DateTime.now();
  TextEditingController transactionNotesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.transaction != null) {
      transactionType = widget.transaction!.isIncome
          ? TransactionType.income
          : TransactionType.expense;
      transactionTitleController.text = widget.transaction!.title;
      transactionCategoryController.text = widget.transaction!.category;
      transactionAmountController.text = widget.transaction!.amount.toString();
      transactionDate = widget.transaction!.date!;
      transactionNotesController.text = widget.transaction!.notes ?? "";
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
            isIncome: transactionType == TransactionType.income,
            title: transactionTitleController.text,
            category: transactionCategoryController.text,
            amount: double.parse(transactionAmountController.text),
            date: transactionDate,
            notes: transactionNotesController.text,
          ),
        )
        .then((value) => Navigator.of(context).pop());
  }

  void _updateTransaction() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    widget.transaction!.isIncome = transactionType == TransactionType.income;
    widget.transaction!.title = transactionTitleController.text;
    widget.transaction!.category = transactionCategoryController.text;
    widget.transaction!.amount = double.parse(transactionAmountController.text);
    widget.transaction!.date = transactionDate;
    widget.transaction!.notes = transactionNotesController.text;
    TransactionDatabase.instance.update(widget.transaction!);
    Navigator.of(context).pop();
  }

  void onTypeToggle(TransactionType newType) {
    setState(() {
      transactionType = newType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          TypeToggle(
            active: transactionType,
            onClick: onTypeToggle,
          ),
          TitleField(inputController: transactionTitleController),
          CategoryField(inputController: transactionCategoryController),
          AmountField(
            label: "Amount",
            inputController: transactionAmountController,
            enabled: true,
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
          NotesField(inputController: transactionNotesController),
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
