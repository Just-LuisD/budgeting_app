import 'package:budgeting_app/cubits/budget_form_cubit.dart';
import 'package:budgeting_app/models/category.dart';
import 'package:budgeting_app/screens/add_budget_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

final NumberFormat currencyFormater = NumberFormat.simpleCurrency();

class BudgetItem extends StatelessWidget {
  final Category category;
  final double amount;
  const BudgetItem({
    super.key,
    required this.category,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    void showBudgetItemForm() {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: BlocProvider.of<BudgetFormCubit>(context),
            child: AddBudgetItemScreen(
              initialCategory: category,
              initialAmount: amount,
            ),
          );
        },
      );
    }

    String displayedAmount = currencyFormater.format(amount);

    return SizedBox(
      height: 75,
      child: Card(
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset(
              category.image,
              scale: 2,
            ),
          ),
          title: Text(category.name),
          subtitle: Text(displayedAmount),
          trailing: IconButton(
            onPressed: showBudgetItemForm,
            icon: const Icon(Icons.edit),
          ),
        ),
      ),
    );
  }
}
