import 'package:budgeting_app/widgets/budget_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 247, 239, 229),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                "You can select one of our templates to get started or build your own from scratch",
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/create-budget/80-20'),
              child: BudgetCard(
                type: BudgetTemplateType.eightyTwenty,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/create-budget/50-30-20'),
              child: BudgetCard(
                type: BudgetTemplateType.fiftyThirtyTwenty,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/create-budget/custom'),
              child: BudgetCard(
                type: BudgetTemplateType.custom,
              ),
            ),
          ],
        ));
  }
}
