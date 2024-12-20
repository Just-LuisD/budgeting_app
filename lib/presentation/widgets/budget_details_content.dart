import 'package:budgeting_app/presentation/widgets/category_section.dart';
import 'package:budgeting_app/presentation/widgets/metrics_section.dart';
import 'package:budgeting_app/presentation/widgets/transaction_section.dart';
import 'package:flutter/material.dart';

class BudgetDetailsContent extends StatelessWidget {
  const BudgetDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Text("Transactions"),
              Text("Categories"),
              Text("Metrics"),
            ],
          ),
          Expanded(
            child: TabBarView(children: [
              TransactionSection(),
              CategorySection(),
              MetricsSection(),
            ]),
          ),
        ],
      ),
    );
  }
}
