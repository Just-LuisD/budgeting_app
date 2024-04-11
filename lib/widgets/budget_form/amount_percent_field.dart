import 'package:budgeting_app/cubits/budget_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmountPercentField extends StatefulWidget {
  const AmountPercentField({super.key});

  @override
  State<AmountPercentField> createState() => _AmountPercentFieldState();
}

class _AmountPercentFieldState extends State<AmountPercentField> {
  late bool isPercent;
  late double amount;
  late double percent;
  late TextEditingController percentController;
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    isPercent = false;
    amount = 0;
    percent = 0;
    amountController = TextEditingController(text: amount.toString());
    percentController = TextEditingController(text: percent.toString());
  }

  void updateValue(String? val) {
    if (isPercent) {
      double value = double.tryParse(percentController.text) ?? 0;
      amount = (value / 100) * context.read<BudgetFormCubit>().state.income;
      setState(() {
        amountController.text = amount.toStringAsFixed(2);
      });
    } else {
      double value = double.tryParse(amountController.text) ?? 0;
      percent = (value / context.read<BudgetFormCubit>().state.income) * 100;
      setState(() {
        percentController.text = percent.toStringAsFixed(2);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: amountController,
            enabled: !isPercent,
            decoration: const InputDecoration(
              labelText: "Amount",
              prefixText: '\$',
            ),
            keyboardType: TextInputType.number,
            onChanged: updateValue,
          ),
        ),
        Checkbox(
          value: !isPercent,
          onChanged: (value) {
            if (value == true) {
              setState(() {
                isPercent = !value!;
              });
            }
          },
        ),
        Expanded(
          child: TextFormField(
            controller: percentController,
            enabled: isPercent,
            textAlign: TextAlign.end,
            decoration: const InputDecoration(
              labelText: "Percent",
              suffixText: "%",
            ),
            keyboardType: TextInputType.number,
            onChanged: updateValue,
          ),
        ),
        Checkbox(
          value: isPercent,
          onChanged: (value) {
            if (value == true) {
              setState(() {
                isPercent = value!;
              });
            }
          },
        ),
      ],
    );
  }
}
