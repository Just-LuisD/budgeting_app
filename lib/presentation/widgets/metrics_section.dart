import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_bloc.dart';
import 'package:budgeting_app/presentation/bloc/budget_details_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MetricsSection extends StatelessWidget {
  const MetricsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetDetailsBloc, BudgetDetailsState>(
      builder: (context, state) {
        Map<String, int> tagTotals = {};
        for (Category category in state.categories) {
          String tag = category.tag!;
          if (tagTotals.containsKey(tag)) {
            tagTotals[tag] = tagTotals[tag]! + category.spendingLimit;
          } else {
            tagTotals[tag] = category.spendingLimit;
          }
        }
        return Container(
          child: PieChart(
            PieChartData(
              sections: tagTotals.keys.map((tag) {
                int percentage =
                    (100 * tagTotals[tag]! / state.budget!.income).round();
                return PieChartSectionData(
                  value: tagTotals[tag]!.toDouble(),
                  title: "$tag - $percentage",
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
