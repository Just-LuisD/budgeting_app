import 'package:budgeting_app/cubits/budget_form_cubit.dart';
import 'package:budgeting_app/widgets/budget_form/amount_field.dart';
import 'package:budgeting_app/widgets/budget_form/budget_creation_piechart.dart';
import 'package:budgeting_app/widgets/budget_form/budget_items_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BudgetForm extends StatelessWidget {
  const BudgetForm({super.key});

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      context.go("/home");
    }

    BudgetFormState formState = context.watch<BudgetFormCubit>().state;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Form(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: AmountField(),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    SizedBox(
                      width: 125,
                      height: 45,
                      child: SegmentedButton(
                        showSelectedIcon: false,
                        segments: const [
                          ButtonSegment(
                            label: Text("Net"),
                            value: IncomeType.netIncome,
                          ),
                          ButtonSegment(
                            label: Text("Gross"),
                            value: IncomeType.grossIncome,
                          ),
                        ],
                        selected: {formState.incomeType},
                        onSelectionChanged: (Set<IncomeType> newSelection) {
                          context
                              .read<BudgetFormCubit>()
                              .setIncomeType(newSelection.first);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: SizedBox(
                height: 200,
                child: BudgetCreationPiechart(),
              ),
            ),
            const BudgetItemsView(),
            Center(
              child: Container(
                padding: const EdgeInsets.all(6),
                width: 300,
                height: 55,
                child: FloatingActionButton(
                  onPressed: onSubmit,
                  child: const Text("Submit"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
