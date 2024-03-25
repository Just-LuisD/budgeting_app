import 'package:budgeting_app/widgets/budget_form/budget_item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BudgetCreationPiechart extends StatelessWidget {
  final double? income;
  final List<BudgetItem>? budgetItems;
  const BudgetCreationPiechart({
    super.key,
    this.income,
    this.budgetItems,
  });

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData>? budgetSections;
    double availabeIncome = income ?? 0;
    if (budgetItems != null) {
      double expenses = 0;
      for (BudgetItem item in budgetItems!) {
        expenses += item.amount;
      }
      availabeIncome -= expenses;
      budgetSections = budgetItems!.map((item) {
        Color randomColor =
            Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0);
        var saturantedColor =
            HSLColor.fromColor(randomColor).withSaturation(0.80);
        randomColor = Color.alphaBlend(
            saturantedColor.toColor(), Color.fromARGB(255, 255, 255, 255));
        return PieChartSectionData(
          title: item.category.name,
          value: item.amount,
          radius: 100,
          showTitle: true,
          color: randomColor,
        );
      }).toList();
    }

    return PieChart(PieChartData(
      centerSpaceRadius: 0,
      sections: [
        if (income != null)
          PieChartSectionData(
            titlePositionPercentageOffset: 0,
            title: "Income",
            value: availabeIncome,
            radius: 100,
            showTitle: true,
            color: Color.fromARGB(255, 203, 255, 119),
          )
        else
          PieChartSectionData(
            titlePositionPercentageOffset: 0,
            title: "Please Add Income",
            value: 1,
            radius: 100,
            showTitle: true,
            color: Color.fromARGB(255, 158, 157, 157),
          ),
        if (budgetSections != null) ...budgetSections,
      ],
    ));
  }
}
