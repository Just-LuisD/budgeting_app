import 'package:budgeting_app/presentation/widgets/category_section.dart';
import 'package:budgeting_app/presentation/widgets/transaction_section.dart';
import 'package:flutter/material.dart';

enum ContentState { transactions, categories }

class BudgetDetailsContent extends StatefulWidget {
  const BudgetDetailsContent({super.key});

  @override
  State<BudgetDetailsContent> createState() => _BudgetDetailsContentState();
}

class _BudgetDetailsContentState extends State<BudgetDetailsContent> {
  ContentState contentState = ContentState.transactions;

  @override
  Widget build(BuildContext context) {
    Widget view;
    switch (contentState) {
      case ContentState.transactions:
        view = const TransactionSection();
      case ContentState.categories:
        view = const CategorySection();
    }

    return DefaultTabController(
      initialIndex: contentState.index,
      length: ContentState.values.length,
      child: Column(
        children: [
          TabBar(
            onTap: (value) {
              setState(() {
                contentState = ContentState.values[value];
              });
            },
            tabs: const [
              Text("Transactions"),
              Text("Categories"),
            ],
          ),
          Expanded(child: view),
        ],
      ),
    );
  }
}
