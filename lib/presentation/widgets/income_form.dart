import 'package:budgeting_app/domain/entities/income.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeForm extends StatefulWidget {
  final Income? income;
  final void Function(Income) onSubmit;

  const IncomeForm({
    super.key,
    required this.onSubmit,
    this.income,
  });

  @override
  State<IncomeForm> createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  var _incomeDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.income != null) {
      _titleController.text = widget.income!.title;
      _amountController.text = widget.income!.amount.toString();
      _incomeDate = DateTime.parse(widget.income!.date);
    }
  }

  void _pickDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _incomeDate,
      firstDate: DateTime(_incomeDate.year, _incomeDate.month, 1),
      lastDate: DateTime(_incomeDate.year, _incomeDate.month + 1, 1).subtract(
        const Duration(days: 1),
      ),
    );

    if (selectedDate != null) {
      setState(() {
        _incomeDate = selectedDate;
      });
    }
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final title = _titleController.text;
    final amount = int.tryParse(_amountController.text.replaceAll(".", ""));

    Income newIncome;
    if (widget.income == null) {
      newIncome =
          Income(title: title, amount: amount!, date: _incomeDate.toString());
    } else {
      newIncome = widget.income!.copy(
        title: title,
        amount: amount,
        date: _incomeDate.toString(),
      );
    }
    widget.onSubmit(newIncome);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.income == null ? "Add Income" : "Edit Income",
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
                  return 'Your income must have a title.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _amountController,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Date: ${DateFormat.yMMMd().format(_incomeDate)}',
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
            ElevatedButton(
              onPressed: _onSubmit,
              child: Text(widget.income == null ? "Add" : "Save"),
            ),
          ],
        ),
      ),
    );
  }
}
