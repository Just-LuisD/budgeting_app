import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeForm extends StatefulWidget {
  const IncomeForm({super.key});

  @override
  State<IncomeForm> createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _amountController = new TextEditingController();
  var _expenseDate = DateTime.now();

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

  void _onSubmit(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Income"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: null,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Your income must have a title.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: null,
                decoration: const InputDecoration(
                  labelText: "Amount",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null ||
                      double.tryParse(value)! <= 0) {
                    return 'Your income amount must be a positive value.';
                  }
                  return null;
                },
              ),
              Row(
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
              ElevatedButton(
                onPressed: () {
                  _onSubmit(context);
                },
                child: const Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
