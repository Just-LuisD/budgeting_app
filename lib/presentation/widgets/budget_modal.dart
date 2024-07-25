import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:flutter/material.dart';

class BudgetModal extends StatefulWidget {
  final Budget? budget;

  const BudgetModal({
    super.key,
    this.budget,
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
      final double income = double.parse(_incomeController.text);

      if (widget.budget == null) {
        final newBudget = Budget(
          name: name,
          income: income,
        );
        // TODO: add budget
      } else {
        final updatedBudget = widget.budget!.copy(name: name, income: income);
        // TODO: update budget
      }
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.budget == null ? "Add Budget" : "Edit Budget"),
      content: Form(
        key: _formKey,
        child: SizedBox(
          height: 150,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Budget Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a budget name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _incomeController,
                decoration: const InputDecoration(labelText: 'Expected Income'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an income amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
            ],
          ),
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
