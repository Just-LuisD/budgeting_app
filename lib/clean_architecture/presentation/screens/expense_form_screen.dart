import 'package:budgeting_app/clean_architecture/domain/entities/expense.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/expense_bloc.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/expense_event.dart';
import 'package:budgeting_app/clean_architecture/presentation/widgets/transaction_form/amount_field.dart';
import 'package:budgeting_app/clean_architecture/presentation/widgets/transaction_form/category_field.dart';
import 'package:budgeting_app/clean_architecture/presentation/widgets/transaction_form/notes_field.dart';
import 'package:budgeting_app/clean_architecture/presentation/widgets/transaction_form/title_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseFormScreen extends StatefulWidget {
  final Expense? expense;
  const ExpenseFormScreen({super.key, this.expense});

  @override
  State<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends State<ExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _amountController = TextEditingController();
  var _expenseDate = DateTime.now();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _titleController.text = widget.expense!.title;
      // TODO: maybe change expense to hold a reference to the category name?
      _categoryController.text = widget.expense!.categoryId.toString();
      _amountController.text = widget.expense!.amount.toString();
      _expenseDate = DateTime.parse(widget.expense!.date);
      _notesController.text = widget.expense!.notes ?? "";
    }
  }

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

  void _submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final title = _titleController.text;
    final category = _categoryController.text;
    final amount = double.tryParse(_amountController.text);
    final date = DateTime.now().toString();
    final notes = _notesController.text;

    if (widget.expense == null) {
      final newExpense = Expense(
        title: title,
        categoryId: 1,
        budgetId: 1,
        amount: amount!,
        date: date,
        notes: notes,
      );
      context.read<ExpenseBloc>().add(AddExpense(newExpense));
    } else {
      final updatedExpense = widget.expense!
          .copy(title: title, amount: amount, date: date, notes: notes);
      context.read<ExpenseBloc>().add(UpdateExpense(updatedExpense));
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.expense == null ? 'Add Transaction' : 'Edit Transaction',
        ),
        actions: widget.expense == null
            ? null
            : [
                IconButton(
                  onPressed: () {
                    context
                        .read<ExpenseBloc>()
                        .add(DeleteExpense(widget.expense!));
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TitleField(inputController: _titleController),
                CategoryField(inputController: _categoryController),
                AmountField(
                  inputController: _amountController,
                  label: "Amount",
                  enabled: true,
                ),
                Row(
                  children: [
                    Text('Date: ${DateFormat.yMMMd().format(_expenseDate)}'),
                    IconButton(
                      onPressed: _pickDate,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
                NotesField(inputController: _notesController),
                ElevatedButton(
                  onPressed: () => _submitForm(context),
                  child: Text(widget.expense == null ? "Add" : "Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
