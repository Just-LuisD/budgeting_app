import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/currency_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ExpenseForm extends StatefulWidget {
  final List<Category> categories;
  final Expense? expense;
  final void Function(Expense) onSubmit;
  final void Function(int)? onDelete;

  const ExpenseForm({
    super.key,
    this.expense,
    this.onDelete,
    required this.categories,
    required this.onSubmit,
  });

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
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
      _amountController.text =
          NumberFormat.simpleCurrency().format(widget.expense!.amount / 100);
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
    final amount =
        int.tryParse(_amountController.text.replaceAll(RegExp("[.,\$]"), ""));
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
      padding: EdgeInsets.all(widget.expense == null ? 0 : 18.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.expense == null ? 'Add Expense' : 'Edit Expense',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (widget.onDelete != null && widget.expense != null)
                    IconButton(
                      onPressed: () {
                        widget.onDelete!(widget.expense!.id!);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                ],
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
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(),
                ],
                decoration: const InputDecoration(
                  labelText: "Amount",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  String parsedValue = value.replaceAll(RegExp("[.,\$]"), "");
                  if (int.tryParse(parsedValue) == null) {
                    return 'Please entee a valid number';
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
                child: Text(widget.expense == null ? "Add" : "Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
