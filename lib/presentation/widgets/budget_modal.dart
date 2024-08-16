import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:budgeting_app/presentation/widgets/currency_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BudgetModal extends StatefulWidget {
  final Budget? budget;
  final void Function(Budget) onSubmit;

  const BudgetModal({
    super.key,
    this.budget,
    required this.onSubmit,
  });

  @override
  State<BudgetModal> createState() => _BudgetModalState();
}

class _BudgetModalState extends State<BudgetModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _incomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.budget != null) {
      _nameController.text = widget.budget!.name;
      _incomeController.text = widget.budget!.income.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _incomeController.dispose();
    super.dispose();
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final income =
          int.parse(_incomeController.text.replaceAll(RegExp("[.,\$]"), ""));
      Budget newBudget;
      if (widget.budget == null) {
        newBudget = Budget(
          name: name,
          income: income,
        );
      } else {
        newBudget = widget.budget!.copy(name: name, income: income);
      }
      widget.onSubmit(newBudget);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.budget == null ? "Add Budget" : "Edit Budget"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Budget Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _incomeController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyInputFormatter(),
              ],
              decoration: const InputDecoration(labelText: 'Expected Income'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an income amount';
                }
                String parsedValue = value.replaceAll(RegExp("[.,\$]"), "");
                if (int.tryParse(parsedValue) == null) {
                  return 'Please entee a valid number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            _submitForm(context);
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
