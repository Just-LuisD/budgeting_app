import 'package:budgeting_app/cubits/budget_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmountField extends StatelessWidget {
  final String label;
  const AmountField({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    double income = context.watch<BudgetFormCubit>().state.income;
    return TextFormField(
        initialValue: income.toString(),
        decoration: InputDecoration(
          labelText: label,
          prefixText: '\$',
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          context
              .read<BudgetFormCubit>()
              .setIncome(double.tryParse(value) ?? 0);
        });
  }
}
