import 'package:budgeting_app/presentation/widgets/income_header.dart';
import 'package:budgeting_app/presentation/widgets/income_list.dart';
import 'package:budgeting_app/test_data.dart';
import 'package:flutter/material.dart';

class IncomeSection extends StatefulWidget {
  const IncomeSection({super.key});

  @override
  State<IncomeSection> createState() => _IncomeSectionState();
}

class _IncomeSectionState extends State<IncomeSection> {
  bool _showList = true;

  void _toggleList() {
    setState(() {
      _showList = !_showList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          IncomeHeader(
            showingList: _showList,
            onToggle: _toggleList,
          ),
          LinearProgressIndicator(
            value: 0.5,
          ),
          if (_showList)
            IncomeList(
              incomeList: testIncome1,
            ),
        ],
      ),
    );
  }
}
