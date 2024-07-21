import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:budgeting_app/presentation/blocs/budget_bloc.dart';
import 'package:budgeting_app/presentation/blocs/budget_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetModal extends StatefulWidget {
  const BudgetModal({super.key});

  @override
  State<BudgetModal> createState() => _BudgetModalState();
}

class _BudgetModalState extends State<BudgetModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _incomeController = TextEditingController();

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final double income = double.parse(_incomeController.text);

      final newBudget = Budget(
        name: name,
        income: income,
      );
      context.read<BudgetBloc>().add(AddBudget(newBudget));

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Budget"),
      content: Form(
        key: _formKey,
        child: Container(
          height: 200,
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
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            _submitForm(context);
          },
          child: Text("Submit"),
        ),
      ],
    );
    ;
  }
}
