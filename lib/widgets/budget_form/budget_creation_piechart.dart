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
        double sectionValue =
            entry.value < 1 ? entry.value * formState.income : entry.value;
        budgetSections.add(
          PieChartSectionData(
            //title: entry.key.name,
            title: sectionValue.toString(),
            titlePositionPercentageOffset: 0.6,
            value: sectionValue,
            radius: 40,
            showTitle: false,
            color: entry.key.color,
            badgeWidget: Image.asset(
              entry.key.image,
              scale: 2.5,
            ),
            badgePositionPercentageOffset: 0.5,
          ),
        );
      }
    }

    return PieChart(PieChartData(
      centerSpaceRadius: 80,
      sections: [
        if (formState.income != 0)
          PieChartSectionData(
            titlePositionPercentageOffset: 0,
            //title: "Income",
            title: formState.remainingIncome.toString(),
            value: formState.remainingIncome,
            radius: 40,
            showTitle: true,
            color: Color.fromARGB(255, 203, 255, 119),
          )
        else
          PieChartSectionData(
            titlePositionPercentageOffset: 0,
            title: "Please Add Income",
            value: 1,
            radius: 40,
            showTitle: true,
            color: Color.fromARGB(255, 158, 157, 157),
          ),
        if (budgetSections != null) ...budgetSections,
      ],
    ));
  }
}
