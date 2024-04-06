import 'package:budgeting_app/cubits/budget_form_cubit.dart';
import 'package:budgeting_app/screens/add_budget_item_screen.dart';
import 'package:budgeting_app/widgets/budget_form/budget_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetItemsView extends StatelessWidget {
  const BudgetItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    BudgetFormState state = context.watch<BudgetFormCubit>().state;
    void showBudgetItemForm() {
      if (state.income <= 0) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              "Please Enter Your Income",
            ),
            content: const Text(
              "You cannod add budget items before providing your monthly income.",
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
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: BlocProvider.of<BudgetFormCubit>(context),
            child: const AddBudgetItemScreen(),
          );
        },
      );
    }

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                context.read<BudgetFormCubit>().toggleShowCategories();
              },
              icon: const Icon(Icons.arrow_drop_down),
            ),
            const Spacer(),
            IconButton(
              alignment: AlignmentDirectional.centerEnd,
              onPressed: showBudgetItemForm,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        SizedBox(
          height: 280,
          child: Center(
            child: BlocBuilder<BudgetFormCubit, BudgetFormState>(
              builder: (context, state) {
                List<Widget> children = [];
                for (var entry in state.budgetItems.entries) {
                  children.add(
                      BudgetItem(category: entry.key, amount: entry.value));
                }
                return ListView(
                  children: [
                    if (state.showCategories)
                      if (children.isNotEmpty)
                        ...(children)
                      else
                        const Text(
                          "No Budget Items Found",
                          textAlign: TextAlign.center,
                        ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
