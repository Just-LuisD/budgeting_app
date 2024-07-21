import 'package:budgeting_app/presentation/widgets/income_form.dart';
import 'package:flutter/material.dart';

class IncomeSection extends StatefulWidget {
  const IncomeSection({super.key});

  @override
  State<IncomeSection> createState() => _IncomeSectionState();
}

class _IncomeSectionState extends State<IncomeSection> {
  bool _showCategories = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                _showCategories = !_showCategories;
              });
            },
            icon: Icon(_showCategories
                ? Icons.arrow_drop_down
                : Icons.arrow_right_outlined),
          ),
          const Expanded(
            child: Text("Income"),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const IncomeForm();
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
