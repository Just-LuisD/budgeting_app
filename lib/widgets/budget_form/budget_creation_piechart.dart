import 'package:budgeting_app/cubits/budget_form_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetCreationPiechart extends StatelessWidget {
  const BudgetCreationPiechart({super.key});

  @override
  Widget build(BuildContext context) {
    BudgetFormState formState = context.watch<BudgetFormCubit>().state;
    List<PieChartSectionData>? budgetSections;
    if (formState.budgetItems.isNotEmpty) {
      budgetSections = [];
      for (var entry in formState.budgetItems.entries) {
        Color randomColor =
            Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0);
        var saturantedColor =
            HSLColor.fromColor(randomColor).withSaturation(0.80);
        randomColor = Color.alphaBlend(
            saturantedColor.toColor(), Color.fromARGB(255, 255, 255, 255));
        budgetSections.add(PieChartSectionData(
          //title: entry.key.name,
          title:
              (entry.value < 1 ? entry.value * formState.income : entry.value)
                  .toString(),
          value: entry.value < 1 ? entry.value * formState.income : entry.value,
          radius: 100,
          showTitle: true,
          color: randomColor,
        ));
      }
    }

    return PieChart(PieChartData(
      centerSpaceRadius: 0,
      sections: [
        if (formState.income != 0)
          PieChartSectionData(
            titlePositionPercentageOffset: 0,
            //title: "Income",
            title: formState.remainingIncome.toString(),
            value: formState.remainingIncome,
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
