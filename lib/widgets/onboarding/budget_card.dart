import 'package:budgeting_app/widgets/piecharts/eighty_twenty_piechart.dart';
import 'package:budgeting_app/widgets/piecharts/fifty_thirty_twenty_piechart.dart';
import 'package:budgeting_app/widgets/piecharts/random_piechart.dart';
import 'package:flutter/material.dart';

enum BudgetTemplateType {
  fiftyThirtyTwenty,
  eightyTwenty,
  custom,
}

class BudgetCard extends StatelessWidget {
  final BudgetTemplateType type;
  const BudgetCard({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    String title;
    Widget icon;
    switch (type) {
      case BudgetTemplateType.fiftyThirtyTwenty:
        title = "50/30/20 Template";
        icon = const FiftyThrityTwentyPiechart();
        break;
      case BudgetTemplateType.eightyTwenty:
        title = "80/20 Template";
        icon = const EightyTwentyPiechart();
        break;
      case BudgetTemplateType.custom:
        title = "Custom";
        icon = const RandomPiechart();
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        surfaceTintColor: const Color.fromARGB(110, 255, 254, 254),
        elevation: 8,
        color: const Color.fromARGB(255, 210, 185, 224),
        child: SizedBox(
          width: 300,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(title),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(right: 16),
                constraints: BoxConstraints.tight(const Size(100, 100)),
                child: icon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
