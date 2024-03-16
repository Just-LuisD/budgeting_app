import 'package:budgeting_app/widgets/transaction_form/amount_field.dart';
import 'package:budgeting_app/widgets/transaction_form/title_field.dart';
import 'package:flutter/material.dart';

class BudgetForm extends StatefulWidget {
  const BudgetForm({super.key});

  @override
  State<BudgetForm> createState() => _BudgetFormState();
}

class _BudgetFormState extends State<BudgetForm> {
  @override
  Widget build(BuildContext context) {
    TextEditingController c = TextEditingController();
    return Form(
        child: ListView(
      children: <Widget>[
        TitleField(inputController: c),
        AmountField(inputController: c),
        Text("Select Categories"),
        ElevatedButton(
          onPressed: null,
          child: Text("Submit"),
        ),
      ]
          .map((child) => Padding(
                padding: EdgeInsets.all(8),
                child: child,
              ))
          .toList(),
    ));
  }
}
