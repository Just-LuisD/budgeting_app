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
        return AspectRatio(
          aspectRatio: 1,
          child: Container(
            margin: const EdgeInsets.all(8),
            child: PieChart(
              PieChartData(
                sections: tagTotals.keys.map((tag) {
                  // TODO: make rounded percentages add up to 100%
                  int percentage =
                      (100 * tagTotals[tag]! / state.budget!.income).round();
                  return PieChartSectionData(
                    value: tagTotals[tag]!.toDouble(),
                    title: "${pieSectionConfig[tag]!["title"]}: $percentage%",
                    color: pieSectionConfig[tag]!["color"],
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    radius: 160,
                  );
                }).toList(),
                centerSpaceRadius: 0,
              ),
            ),
          ),
        );
      },
    );
  }
}

Map<String, Map<String, dynamic>> pieSectionConfig = {
  "": {
    "color": Colors.grey,
    "title": "Misc",
  },
  "fixed": {
    "color": Colors.red,
    "title": "Fixed",
  },
  "savings": {
    "color": Colors.green,
    "title": "Savings",
  },
  "fun": {
    "color": Colors.blue,
    "title": "Fun",
  },
};
