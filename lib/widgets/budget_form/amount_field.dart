import 'package:budgeting_app/cubits/budget_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

final NumberFormat currencyFormater = NumberFormat.simpleCurrency();

class AmountField extends StatefulWidget {
  const AmountField({
    super.key,
  });

  @override
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
  late TextEditingController controller;
  late bool enabled;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.text =
        currencyFormater.format(context.read<BudgetFormCubit>().state.income);
    enabled = false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void edit() {
    setState(() {
      enabled = true;
    });
    context.read<BudgetFormCubit>().setIncome(0);
  }

  void submit() {
    String text = controller.text;
    text = text.replaceAll(",", "");
    text = text.replaceAll("\$", "");
    double? parsedText = double.tryParse(text);
    if (parsedText == null || parsedText <= 0) {
      setState(() {
        controller.text = "";
      });
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            "Invalid Income",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text("Dismiss"),
            ),
          ],
        ),
      );
      return;
    }
    setState(() {
      controller.text = currencyFormater.format(parsedText);
      enabled = false;
    });
    context.read<BudgetFormCubit>().setIncome(parsedText.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.end,
        textAlignVertical: TextAlignVertical.center,
        readOnly: !enabled,
        decoration: InputDecoration(
          filled: !enabled,
          fillColor: const Color.fromARGB(72, 176, 174, 174),
          labelText: "Monthly Income",
          prefix: IconButton(
            icon: Icon(enabled ? Icons.check : Icons.edit),
            onPressed: enabled ? submit : edit,
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
