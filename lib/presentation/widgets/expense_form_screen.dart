import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseFormScreen extends StatefulWidget {
  final List<Category> categories;
  final Expense? expense;
  final void Function(Expense) onSubmit;

  const ExpenseFormScreen({
    super.key,
    this.expense,
    required this.categories,
    required this.onSubmit,
  });

  @override
  State<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends State<ExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  int? _selectedCategory;
  final _amountController = TextEditingController();
  var _expenseDate = DateTime.now();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _titleController.text = widget.expense!.title;
      _selectedCategory = widget.expense!.categoryId;
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
        const Duration(days: 1),
      ),
    );

    if (selectedDate != null) {
      setState(() {
        _expenseDate = selectedDate;
      });
    }
  }

  void _submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate() || _selectedCategory == null) {
      return;
    }

    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);
    final notes = _notesController.text;

    Expense newExpense;
    if (widget.expense == null) {
      newExpense = Expense(
        title: title,
        categoryId: _selectedCategory!,
        amount: amount!,
        date: _expenseDate.toString(),
        notes: notes,
      );
    } else {
      newExpense = widget.expense!.copy(
        title: title,
        categoryId: _selectedCategory!,
        amount: amount,
        date: _expenseDate.toString(),
        notes: notes,
      );
    }

    widget.onSubmit(newExpense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                widget.expense == null ? 'Add Transaction' : 'Edit Transaction',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _titleController,
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
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: "Amount",
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Date: ${DateFormat.yMMMd().format(_expenseDate)}',
                      ),
                    ),
                    IconButton(
                      alignment: Alignment.centerRight,
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.centerLeft,
                child: DropdownMenu(
                  initialSelection: _selectedCategory,
                  onSelected: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  width: 320,
                  label: const Text("Category"),
                  dropdownMenuEntries: widget.categories.map(
                    (e) {
                      return DropdownMenuEntry(value: e.id, label: e.name);
                    },
                  ).toList(),
                  inputDecorationTheme: const InputDecorationTheme(
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              TextFormField(
                maxLines: 8,
                controller: _notesController,
                decoration: const InputDecoration(
                  label: Text("Notes"),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () => _submitForm(context),
                child: Text(widget.expense == null ? "Add" : "Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
