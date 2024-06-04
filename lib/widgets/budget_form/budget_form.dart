import 'package:budgeting_app/widgets/budget_form/amount_field.dart';
import 'package:budgeting_app/widgets/budget_form/budget_creation_piechart.dart';
import 'package:budgeting_app/widgets/budget_form/budget_items_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BudgetForm extends StatelessWidget {
  const BudgetForm({super.key});

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      // TODO: save to database
      context.go("/home");
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Form(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: AmountField(),
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
